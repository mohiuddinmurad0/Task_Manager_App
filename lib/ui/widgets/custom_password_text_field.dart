import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  const CustomPasswordTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.maxLines,
    this.validator,
    this.readOnly,
    required this.textInputType,
    this.icon,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLines;
  final Function(String?)? validator;
  final bool? readOnly;
  final TextInputType textInputType;
  final IconData? icon;

  @override
  // ignore: library_private_types_in_public_api
  _CustomPasswordTextFormFieldState createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      readOnly: widget.readOnly ?? false,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      controller: widget.controller,
      obscureText: _isObscured && widget.obscureText != null
          ? widget.obscureText!
          : false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: widget.hintText,
        filled: true,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          child: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
