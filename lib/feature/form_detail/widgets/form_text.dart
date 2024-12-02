import 'package:flutter/cupertino.dart';

class FormText extends StatelessWidget {
  final String title;

  const FormText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
