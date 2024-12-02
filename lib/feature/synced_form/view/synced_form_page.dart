import 'package:clover_form/feature/synced_form/view/synced_form_view.dart';
import 'package:flutter/material.dart';

class SyncedFormPage extends StatelessWidget {
  const SyncedFormPage({super.key, required this.formID});

  final String formID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synced Forms'),
      ),
      body: SyncedFormView(
        formID: formID,
      ),
    );
  }
}
