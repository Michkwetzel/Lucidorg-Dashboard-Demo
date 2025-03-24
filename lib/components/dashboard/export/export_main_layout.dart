import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/exportPDF/exportStatusNotifier.dart';
import 'package:platform_front/notifiers/exportPDF/exportWidgetsNotifier.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'dart:html' as html;

class ExportMainLayout extends ConsumerStatefulWidget {
  const ExportMainLayout({super.key});

  @override
  ConsumerState<ExportMainLayout> createState() => _ExportMainLayoutState();
}

class _ExportMainLayoutState extends ConsumerState<ExportMainLayout> {
  final Map<String, GlobalKey> _widgetKeys = {};
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    // Initialize keys for all widgets after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final widgets = ref.read(exportsWidgetsProvider).widgets;
      for (int i = 0; i < widgets.length; i++) {
        _widgetKeys[i.toString()] = GlobalKey();
      }
      // Set the initial state of the export status
      ref.read(exportStatusProvider.notifier).startExport(widgets.length);
    });
  }

  Future<Uint8List?> _captureWidget(GlobalKey key) async {
    try {
      final context = key.currentContext;
      if (context == null) {
        print('Context is null for key');
        return null;
      }

      // Ensure the widget is fully rendered
      await Future.delayed(const Duration(milliseconds: 800));

      final boundary = context.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        print('Boundary is null');
        return null;
      }

      // Use higher pixel ratio for better quality
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('ByteData is null');
        return null;
      }

      return byteData.buffer.asUint8List();
    } catch (e) {
      print('Error capturing widget: $e');
      return null;
    }
  }

  Future<void> exportPDF() async {
    if (_isExporting) return;

    setState(() {
      _isExporting = true;
    });

    try {
      final pdf = pw.Document();
      final widgets = ref.read(exportsWidgetsProvider).widgets;

      // Update the export status
      ref.read(exportStatusProvider.notifier).startExport(widgets.length);

      // First pass: ensure all widgets are visible and rendered
      for (int i = 0; i < widgets.length; i++) {
        ref.read(exportsWidgetsProvider.notifier).setCurrentWidget(i);
        ref.read(exportStatusProvider.notifier).updateProgress(i);
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // Second pass: capture each widget
      bool hasAddedPage = false;

      for (int i = 0; i < widgets.length; i++) {
        final widget = widgets[i];
        final key = _widgetKeys[i.toString()]!;

        ref.read(exportsWidgetsProvider.notifier).setCurrentWidget(i);
        ref.read(exportStatusProvider.notifier).updateProgress(i);

        // Make sure the widget is rendered
        await Future.delayed(const Duration(milliseconds: 1000));

        final imageBytes = await _captureWidget(key);

        if (imageBytes != null && imageBytes.isNotEmpty) {
          hasAddedPage = true;

          pdf.addPage(
            pw.Page(
              margin: const pw.EdgeInsets.all(24),
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(widget.title, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 20),
                    pw.Center(
                      child: pw.Image(
                        pw.MemoryImage(imageBytes),
                        fit: pw.BoxFit.contain,
                      ),
                    ),
                  ],
                );
              },
            ),
          );

          print('Successfully added page for ${widget.title}');
        } else {
          print('Failed to capture widget ${widget.title}');
        }
      }

      // Ensure we have at least one page
      if (!hasAddedPage) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text('No content could be exported', style: pw.TextStyle(fontSize: 18)),
              );
            },
          ),
        );
      }

      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Open in a new tab
      html.window.open(url, "_blank");

      // Or trigger a download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'export_${DateTime.now().millisecondsSinceEpoch}.pdf')
        ..style.display = 'none';

      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);

      html.Url.revokeObjectUrl(url);

      ref.read(exportStatusProvider.notifier).exportDone();
    } catch (e) {
      print('Error exporting PDF: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to export PDF: ${e.toString()}'),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgets = ref.watch(exportsWidgetsProvider).widgets;
    final exportStatus = ref.watch(exportStatusProvider);

    return Column(
      children: [
        Text("Export", style: kH2PoppinsLight),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _isExporting ? null : exportPDF,
          icon: _isExporting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.picture_as_pdf),
          label: Text(_isExporting ? "Exporting..." : "Export all graphs"),
        ),

        if (_isExporting)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: widgets.isEmpty ? 0 : exportStatus.currentWidgetIndex / exportStatus.totalWidgets,
                ),
                const SizedBox(height: 8),
                Text(
                  "Processing widget ${exportStatus.currentWidgetIndex + 1} of ${exportStatus.totalWidgets}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

        // Render widgets in a Column with proper visibility
        // This is a key change: don't hide the widgets completely
        const SizedBox(height: 20),
        const Divider(),
        const Text("Preview (scrollable)", style: TextStyle(fontSize: 12)),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < widgets.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widgets[i].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const Divider(),
                        RepaintBoundary(
                          key: _widgetKeys[i.toString()],
                          child: SizedBox(
                            width: 1000,
                            height: 1000,
                            child: widgets[i].widgetBuilder(),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
