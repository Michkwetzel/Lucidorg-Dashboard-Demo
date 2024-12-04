import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class TextfieldGray extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoading;
  final bool error;
  final String errorText;
  final Function(String) onTextChanged;

  const TextfieldGray({super.key, this.width = -1, this.height = -1, required this.onTextChanged, this.isLoading = false, this.error = false, this.errorText = ''});

  TextField textField() {
    return TextField(
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: error ? BorderSide(color: Colors.red.shade400) : BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
