import 'package:clover_form/feature/saved_form/view/saved_form_view.dart';
import 'package:flutter/material.dart';

class SavedFormPage extends StatelessWidget {
  const SavedFormPage({super.key, required this.formID});

  final String formID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Forms'),
      ),
      body: SavedFormView(
        formID: formID,
      ),
    );
  }
}
