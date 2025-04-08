// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final String text;
  final VoidCallback onPresse;
  final String buttonText;
  const SignUpButton({
    Key? key,
    required this.text,
    required this.onPresse,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5),
        ),
        const SizedBox(
          width: 4,
        ),
        TextButton(
          onPressed: onPresse,
          child: Text(
            buttonText,
            style: const TextStyle(letterSpacing: 0.7),
          ),
        ),
      ],
    );
  }
}
