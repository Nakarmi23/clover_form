import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormNumberTextField extends StatelessWidget {
  const FormNumberTextField({
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: borderColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              borderSide: BorderSide(color: Colors.black, width: 4),
            ),
          ),
        ),
      ],
    );
  }
}
