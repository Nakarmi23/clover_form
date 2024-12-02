import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.leadingIcon,
      required this.isPassword});

  final TextEditingController controller;
  final String hint;
  final IconData leadingIcon;
  final bool isPassword;

  @override
  State<StatefulWidget> createState() => LoginTextFieldState();
}

class LoginTextFieldState extends State<LoginTextField> {
  late bool isHidden = widget.isPassword;

  void _toggleHidden() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textAlign: TextAlign.start,
      obscureText: isHidden,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.leadingIcon),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => _toggleHidden(),
                icon: isHidden
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off))
            : null,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.black, width: 4)),
        hintText: widget.hint,
      ),
      style: const TextStyle(
      ),
    );
  }
}
