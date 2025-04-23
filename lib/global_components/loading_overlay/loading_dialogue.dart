// In a utilities file like lib/utils/loading_dialog_utils.dart
import 'package:flutter/material.dart';
import 'package:platform_front/global_components/logo_spin_animation.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/create_job_buttons_widget.dart';

class LoadingDialog {
  static Future<T> showDuringAsync<T>({
    required BuildContext context,
    required Future<T> Function() asyncOperation,
  }) async {
    // Store context in a variable that can be closed over by the future
    final dialogContext = context;
    
    // Show dialog
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: dialogContext,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: LogoSpinAnimation(),
          ),
        );
      },
    );
    
    try {
      // Run the async operation
      final result = await asyncOperation();
      
      // Close dialog if context is still valid
      if (dialogContext.mounted) {
        Navigator.of(dialogContext, rootNavigator: true).pop();
      }
      
      return result;
    } catch (e) {
      // Make sure to close dialog even if there's an error
      if (dialogContext.mounted) {
        Navigator.of(dialogContext, rootNavigator: true).pop();
      }
      rethrow; // Rethrow the error so caller can handle it
    }
  }
}