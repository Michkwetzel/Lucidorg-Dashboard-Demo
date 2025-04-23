import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class TextfieldGray extends StatelessWidget {
  final double height;
  final bool isLoading;
  final bool error;
  final String? errorText;
  final String hintText;
  final IconData? leadingIcon;
  final Function(String) onTextChanged;
  final VoidCallback onSubmitted;
  final VoidCallback onTap;
  final FocusNode? focusNode;
  final TextEditingController controller;

  const TextfieldGray(
      {super.key,
      required this.height,
      this.onTextChanged = _emptyFunction1,
      this.isLoading = false,
      this.error = false,
      this.errorText,
      this.hintText = '',
      this.leadingIcon,
      this.onSubmitted = _emptyFunction0,
      this.onTap = _emptyFunction2,
      this.focusNode,
      required this.controller});

  static void _emptyFunction0() {}
  static void _emptyFunction1(String value) {}
  static void _emptyFunction2() {}

  TextField textField() {
    return TextField(
      focusNode: focusNode,
      expands: true,
      maxLines: null,
      minLines: null,
      controller: controller,
      onTap: onTap,
      onSubmitted: (value) => onSubmitted(),
      onChanged: onTextChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Color(0xFF777777), fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 14),
        hintText: hintText,
        prefixIcon: leadingIcon != null
            ? Icon(
                leadingIcon,
                color: Color(0xFF777777),
              )
            : null,
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
    return error && errorText != ''
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height, child: textField()),
              const SizedBox(
                height: 2,
              ),
              Text(
                errorText!,
                style: kErrorTextFieldTextStyle,
              )
            ],
          )
        : SizedBox(height: height, child: textField());
  }
}
