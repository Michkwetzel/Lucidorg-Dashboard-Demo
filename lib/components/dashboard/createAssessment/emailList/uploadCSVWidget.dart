import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:logging/logging.dart';

class UploadCSVWidget extends StatefulWidget {
  final Function(List<String>, bool error) onDataExtracted;

  const UploadCSVWidget({super.key, required this.onDataExtracted});

  @override
  State<UploadCSVWidget> createState() => _UploadCSVWidgetState();
}

class _UploadCSVWidgetState extends State<UploadCSVWidget> {
  Logger logger = Logger('UploadCSVWidget');
  List<String> validEmails = [];
  String displayText = "Click or drag CSV file here";
  late DropzoneViewController controller;
  String csvContent = '';
  bool isLoading = false;
  bool isHovering = false;
  bool success = false;

  // Email validation regex
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> handleDrop(DropzoneFileInterface file) async {
    setState(() => isLoading = true);

    try {
      // Check if it's a CSV file
      final mime = await controller.getFileMIME(file);
      if (!mime.contains('csv') && !mime.contains('text/plain')) {
        throw 'Please upload a CSV file';
      }

      // Get the file data as bytes
      final data = await controller.getFileData(file);

      // Convert bytes to string
      csvContent = String.fromCharCodes(data);

      // Parse CSV content and validate emails
      final rows = csvContent.split('\n');

      for (var i = 0; i < rows.length; i++) {
        final row = rows[i].trim();
        if (row.isEmpty) continue;

        final columns = row.split(',');
        if (columns.length != 1) {
          displayText = 'Row ${i + 1} contains multiple columns';
          throw 'CSV validation failed:\n$displayText';
        }

        final email = columns[0].trim();
        if (!emailRegex.hasMatch(email)) {
          displayText = 'Invalid email format in row ${i + 1}: $email';
          throw 'CSV validation failed:\n$displayText';
        }

        validEmails.add(email);
      }

      if (validEmails.isEmpty) {
        displayText = 'No valid emails found in the CSV file';
        throw 'No valid emails found in the CSV file';
      }

      // Send valid emails back to parent
      widget.onDataExtracted(validEmails, false);
      setState(() {
        displayText = "Successfully loaded ${validEmails.length} emails";
        success = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully loaded ${validEmails.length} emails')),
      );
    } catch (e) {
      widget.onDataExtracted([], true);
      displayText = 'Error processing CSV';
      logger.info('Error processing CSV: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> handleClick() async {
    final files = await controller.pickFiles(
      multiple: false,
      mime: ['text/csv', 'text/plain'],
    );
    if (files.isNotEmpty) {
      await handleDrop(files.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 330,
      child: Stack(
        children: [
          Positioned.fill(
            child: DropzoneView(
              operation: DragOperation.copy,
              cursor: CursorType.pointer,
              onCreated: (ctrl) => controller = ctrl,
              onDropFile: handleDrop,
              onHover: () => setState(() => isHovering = true),
              onLeave: () => setState(() => isHovering = false),
              onError: (err) => debugPrint('Dropzone error: $err'),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: handleClick,
              child: DottedBorder(
                color: isHovering || success ? Colors.blue : Colors.grey,
                strokeWidth: 1,
                dashPattern: const [5, 5],
                radius: const Radius.circular(10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isLoading ? Icons.hourglass_empty : Icons.upload_file,
                        size: 32,
                        color: isHovering || success ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else if (csvContent.isEmpty)
                        Text(
                          displayText,
                          style: TextStyle(
                            color: isHovering || success ? Colors.blue : Colors.grey,
                          ),
                        )
                      else
                        Text(
                          displayText,
                          style: TextStyle(
                            color: isHovering || success ? Colors.blue : Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
