import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    this.controller,
    required this.hint,
    required this.borderColor,
    this.readOnly = false,
    this.initialValue,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String hint;
  final Color borderColor;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: borderColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          controller: controller,
          textAlign: TextAlign.start,
          readOnly: readOnly,
          decoration: InputDecoration(
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
