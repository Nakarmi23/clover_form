import 'package:flutter/cupertino.dart';

class HomeErrorPage extends StatelessWidget {
  const HomeErrorPage({super.key, required this.errorMsg});

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMsg),
    );
  }
}
