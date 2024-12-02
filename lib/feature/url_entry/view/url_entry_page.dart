import 'package:clover_form/feature/shared/alerts.dart';
import 'package:clover_form/feature/url_entry/view/url_entry_view.dart';
import 'package:clover_form/network/repositories/url_entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/url_entry_cubit.dart';

class UrlEntryPage extends StatelessWidget {
  const UrlEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UrlEntryRepository(),
      child: BlocProvider(
        create: (context) => UrlEntryCubit(
            urlEntryRepository:
                RepositoryProvider.of<UrlEntryRepository>(context)),
        child: BlocListener<UrlEntryCubit, UrlEntryState>(
          listener: (context, state) => addAlertListener(context, state,
              () => {context.read<UrlEntryCubit>().updateState()}),
          child: const UrlEntryView(),
        ),
      ),
    );
  }

  void addAlertListener(
      BuildContext context, UrlEntryState state, Function updateState) {
    if (state.status == UrlEntryStatus.failure) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return Alerts.showAlert("Error Message", state.errorMsg ?? "");
          }).then((value) => {updateState()});
    } else if (state.status == UrlEntryStatus.success) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/confirmation',arguments: state.urlEntry);
    } else if (state.status == UrlEntryStatus.loading) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return WillPopScope(
                onWillPop: () async => false, child: Alerts.loadingAlert());
          });
    }
  }
}
