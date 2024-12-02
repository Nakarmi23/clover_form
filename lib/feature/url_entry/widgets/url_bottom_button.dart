import 'package:flutter/material.dart';

class UrlBottomButton extends StatelessWidget {
  const UrlBottomButton({super.key, required this.onButtonPressed});

  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onButtonPressed()},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4E0189),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      child: const Text(
        "OK",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
