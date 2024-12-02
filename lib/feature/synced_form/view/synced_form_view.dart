import 'package:clover_form/feature/synced_form/cupit/synced_form_cupit.dart';
import 'package:clover_form/feature/synced_form/view/synced_form_child.dart';
import 'package:clover_form/network/repositories/form_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncedFormView extends StatelessWidget {
  const SyncedFormView({super.key, required this.formID});

  final String formID;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FormRepository(),
      child: BlocProvider(
        create: (context) =>
            SyncedFormsCubit(RepositoryProvider.of<FormRepository>(context)),
        child: SyncedFormChild(
          formID: formID,
        ),
      ),
    );
  }
}
