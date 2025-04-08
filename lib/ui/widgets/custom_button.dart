import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPresse;
  const CustomButton({
    Key? key,
    required this.onPresse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPresse,
        child: const Icon(Icons.arrow_circle_right_outlined),
      ),
    );
  }
}
