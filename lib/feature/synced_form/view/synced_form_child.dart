import 'package:clover_form/feature/synced_form/cupit/synced_form_cupit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncedFormChild extends StatelessWidget {
  const SyncedFormChild({super.key, required this.formID});

  final String formID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncedFormsCubit, SyncedFormsState>(
      bloc: context.read<SyncedFormsCubit>()..loadSavedForms(formID),
      builder: (context, state) {
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, SyncedFormsState state) {
    return state.status == SyncedFormsStatus.error
        ? Center(child: Text(state.error!))
        : state.status == SyncedFormsStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.savedForms!.length,
                      itemBuilder: (context, index) {
                        final savedForm = state.savedForms![index];
                        return Container(
                          color: Colors.grey[200],
                          child: ListTile(
                            title: Text(
                                "${savedForm.DataCollectionFormName} - ${savedForm.projectName}"),
                            subtitle: Text(savedForm.date),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Colors.white),
                    ),
                  ),
                ],
              );
  }
}
