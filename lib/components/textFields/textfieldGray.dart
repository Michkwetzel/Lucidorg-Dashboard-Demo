import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class TextfieldGray extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoading;
  final bool error;
  final String errorText;
  final Function(String) onTextChanged;
  final VoidCallback onSubmitted;
  final TextEditingController controller;

  const TextfieldGray(
      {super.key,
      this.width = -1,
      this.height = -1,
      this.onTextChanged = _emptyFunction1,
      this.isLoading = false,
      this.error = false,
      this.errorText = '',
      this.onSubmitted = _emptyFunction0,
      required this.controller});

  static void _emptyFunction0() {}
  static void _emptyFunction1(String value){}

  TextField textField() {
    return TextField(
      controller: controller,
      onSubmitted: (value) => onSubmitted(),
      onChanged: onTextChanged,
      decoration: InputDecoration(
        suffixIcon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ))
            : null,
        filled: true,
        fillColor: error ? Colors.white : const Color(0xFFF3F3F3),
        enabledBorder: error
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red.shade400, width: 1),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
        focusedBorder: error
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red.shade400, width: 1),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Error: $error');
    print('Error Text: $errorText');
    return error
        ? Flexible(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textField(),
              const SizedBox(
                height: 2,
              ),
              Text(
                errorText,
                style: kErrorTextFieldTextStyle,
              )
            ],
          ))
        : Flexible(child: textField());
  }
}
