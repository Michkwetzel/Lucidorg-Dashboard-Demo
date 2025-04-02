import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleSignInButton({required this.onPressed, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 230,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/icons8-google.svg',
              fit: BoxFit.contain,
              height: 30,
            ),
            const SizedBox(
              width: 6,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                : const Text(
                    'Google Sign in',
                    style: TextStyle(fontSize: 14, fontFamily: 'OpenSans', fontWeight: FontWeight.w400, color: Colors.black87),
                  )
          ],
        ),
      ),
    );
  }
}
