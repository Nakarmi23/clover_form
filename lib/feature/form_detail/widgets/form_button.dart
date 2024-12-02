import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton(
      {super.key, required this.onButtonPressed, required this.title});

  final Function onButtonPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {onButtonPressed()},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4E0189),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
