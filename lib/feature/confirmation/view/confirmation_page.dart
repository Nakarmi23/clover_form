import 'package:clover_form/feature/confirmation/cubit/confirmation_cubit.dart';
import 'package:clover_form/feature/url_entry/models/url_entry.dart';
import 'package:clover_form/network/repositories/url_entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/alerts.dart';
import 'confirmation_view.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key, required this.urlEntry});

  final UrlEntry urlEntry;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UrlEntryRepository(),
      child: BlocProvider(
        create: (context) => ConfirmationCubit(
          urlEntryRepository:
              RepositoryProvider.of<UrlEntryRepository>(context),
        ),
        child: BlocListener<ConfirmationCubit, ConfirmationState>(
          listener: (context, state) => addAlertListener(context, state,
              () => {context.read<ConfirmationCubit>().updateState()}),
          child: ConfirmationView(
            urlEntry: urlEntry,
          ),
        ),
      ),
    );
  }

  void addAlertListener(
      BuildContext context, ConfirmationState state, Function updateState) {
    if (state.status == ConfirmationStatus.failure) {
      showDialog(
          context: context,
          builder: (context) {
            return Alerts.showAlert("Error Message", state.errorMsg ?? "");
          }).then((value) => {updateState()});
    } else if (state.status == ConfirmationStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    }
  }
}
