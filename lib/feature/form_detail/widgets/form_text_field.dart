import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.borderColor,
  });

  final TextEditingController controller;
  final String hint;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: borderColor
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textAlign: TextAlign.start,
          decoration:  InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              borderSide: BorderSide(color: borderColor, width: 4),
            ),
          ),
        ),
      ],
    );
  }
}
