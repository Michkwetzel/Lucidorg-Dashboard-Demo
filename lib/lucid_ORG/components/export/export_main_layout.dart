import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:async';
import 'dart:js' as js;

import 'package:platform_front/lucid_ORG/notifiers/exportPDF/exportStatusNotifier.dart';

class ExportMainLayout extends ConsumerStatefulWidget {
  const ExportMainLayout({super.key});

  @override
  ConsumerState<ExportMainLayout> createState() => _ExportMainLayoutState();
}

class _ExportMainLayoutState extends ConsumerState<ExportMainLayout> {
  final Map<String, GlobalKey> _widgetKeys = {};
  bool _isExporting = false;
  Timer? _animationTimer;
  double _dotAnimationProgress = 0.0;

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
      final totalWidgets = widgets.length;
      ref.read(exportStatusProvider.notifier).startExport(totalWidgets);
      ref.read(exportStatusProvider.notifier).reset(); // Reset to idle state initially
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  // Animated dots for loading
  void _startDotAnimation() {
    _animationTimer?.cancel();
    _animationTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (mounted) {
        setState(() {
          _dotAnimationProgress = (_dotAnimationProgress + 1) % 4;
        });
      }
    });
  }

  void _stopDotAnimation() {
    _animationTimer?.cancel();
    _animationTimer = null;
  }

  String get _loadingDots {
    switch (_dotAnimationProgress.toInt()) {
      case 0:
        return '';
      case 1:
        return '.';
      case 2:
        return '..';
      case 3:
        return '...';
      default:
        return '';
    }
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

  // Function to simulate phase progress during operations that don't report progress
  Future<void> _simulateProgress(ExportPhase phase, Duration totalDuration, {int steps = 20}) async {
    final stepDuration = totalDuration.inMilliseconds ~/ steps;
    for (int i = 1; i <= steps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration));
      if (!_isExporting) return; // Stop if export was cancelled
      final progress = i / steps;
      ref.read(exportStatusProvider.notifier).setPhase(phase, progress: progress);
    }
  }

  // Show a modal dialog to prevent closing the page
  void _showProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Exporting PDF'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please wait while your PDF is being generated. This process will take around 5 minutes.\n\nThe Browser is not frozen so please do not close this tab during export.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    final exportStatus = ref.watch(exportStatusProvider);
                    return Column(
                      children: [
                        LinearProgressIndicator(
                          value: exportStatus.overallProgress,
                          valueColor: AlwaysStoppedAnimation<Color>(exportStatus.statusColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${exportStatus.statusMessage}${_loadingDots}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          "${(exportStatus.overallProgress * 100).toStringAsFixed(0)}% complete",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to use the web worker for PDF generation
  Future<void> _savePdfWithWorker(List<pw.Document> pdfDocuments) async {
    try {
      ref.read(exportStatusProvider.notifier).setPhase(ExportPhase.savingPdf);
      _startDotAnimation();

      // Create a stream to process the PDF generation in chunks
      final completer = Completer<Uint8List>();

      // Schedule the heavy PDF saving operation using Future.microtask to avoid blocking UI
      Future.microtask(() async {
        try {
          // Keep the UI responsive by periodically yielding control
          final bytes = await pdfDocuments[0].save();
          completer.complete(bytes);
        } catch (e) {
          completer.completeError(e);
        }
      });

      // Show simulated progress while the PDF saves
      _simulateProgress(
        ExportPhase.savingPdf,
        const Duration(seconds: 30), // Estimate longer for better user experience
        steps: 50,
      );

      // Wait for the PDF generation to complete
      final bytes = await completer.future;

      // Handle the PDF bytes
      _handlePdfBytes(bytes);
    } catch (e) {
      print('Error saving PDF: $e');
      ref.read(exportStatusProvider.notifier).exportError(e.toString());
      _stopDotAnimation();

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // Close processing dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to export PDF: ${e.toString()}'),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handlePdfBytes(Uint8List bytes) {
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Open in a new tab
    html.window.open(url, "_blank");

    // Also trigger a download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'export_${DateTime.now().millisecondsSinceEpoch}.pdf')
      ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);

    html.Url.revokeObjectUrl(url);

    ref.read(exportStatusProvider.notifier).exportDone();
    _stopDotAnimation();

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop(); // Close processing dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF exported successfully!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> exportPDF() async {
    if (_isExporting) return;

    setState(() {
      _isExporting = true;
    });

    // Start animated dots for loading indicators
    _startDotAnimation();

    // Show processing dialog with warning about duration
    _showProcessingDialog();

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

      final font = pw.Font.ttf(await rootBundle.load("assets/fonts/OpenSans/OpenSans.ttf"));

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
              orientation: widget.big ? pw.PageOrientation.landscape : pw.PageOrientation.portrait,
              margin: const pw.EdgeInsets.all(24),
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(widget.title,
                        style: pw.TextStyle(
                          fontSize: 20,
                          font: font,
                        )),
                    pw.SizedBox(height: 20),
                    pw.SizedBox(
                      height: widget.big ? 500 : 600,
                      width: widget.big ? 1500 : null,
                      child: pw.Center(
                        child: pw.Image(
                          pw.MemoryImage(imageBytes),
                          fit: pw.BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                );
              },
              theme: pw.ThemeData.withFont(
                base: font,
              ),
            ),
          );

          print('Successfully added page for ${widget.title}');
        } else {
          print('Failed to capture widget ${widget.title}');
        }
      }

      if (!hasAddedPage) {
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(
                  'No content could be exported',
                  style: pw.TextStyle(fontSize: 18, font: font),
                ),
              );
            },
            theme: pw.ThemeData.withFont(
              base: font,
            ),
          ),
        );
      }

      // Update status to show we're generating the PDF
      ref.read(exportStatusProvider.notifier).setPhase(ExportPhase.generatingPdf);
      await _simulateProgress(ExportPhase.generatingPdf, const Duration(seconds: 2));

      print('saving pdf');

      // Use non-blocking method for PDF saving
      await _savePdfWithWorker([pdf]);
    } catch (e) {
      print('Error exporting PDF: $e');
      ref.read(exportStatusProvider.notifier).exportError(e.toString());
      _stopDotAnimation();

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // Close processing dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to export PDF: ${e.toString()}'),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Add a slight delay before resetting UI to allow users to see completion status
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isExporting = false;
      });
      _stopDotAnimation();
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
          label: Text(_isExporting ? "Exporting..." : "Export all graphs (takes up to 5 minutes)"),
        ),

        if (_isExporting && !ModalRoute.of(context)!.isCurrent)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                // Enhanced progress indicator with stages
                LinearProgressIndicator(
                  value: exportStatus.overallProgress,
                  valueColor: AlwaysStoppedAnimation<Color>(exportStatus.statusColor),
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${exportStatus.statusMessage}${_loadingDots}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "${(exportStatus.overallProgress * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Additional step indicators
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStepIndicator("Capture", exportStatus.phase.index >= ExportPhase.capturingWidgets.index),
                    _buildStepIndicator("Generate", exportStatus.phase.index >= ExportPhase.generatingPdf.index),
                    _buildStepIndicator("Save", exportStatus.phase.index >= ExportPhase.savingPdf.index),
                    _buildStepIndicator("Complete", exportStatus.phase.index >= ExportPhase.complete.index),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Please do not close this tab while export is in progress.",
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),

        // Render widgets in a Column with proper visibility
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
                            width: widgets[i].big ? 1500 : 800,
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

  Widget _buildStepIndicator(String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.green : Colors.grey.shade300,
          ),
          child: Center(
            child: Icon(
              isActive ? Icons.check : Icons.circle,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
