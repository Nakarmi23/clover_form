import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cupit/saved_forms_cubit.dart';

class SavedFormChild extends StatelessWidget {
  const SavedFormChild({super.key, required this.formID});

  final String formID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedFormsCubit, SavedFormsState>(
      bloc: context.read<SavedFormsCubit>()..loadSavedForms(formID),
      builder: (context, state) {
        return BlocListener<SavedFormsCubit, SavedFormsState>(
          bloc: context.read<SavedFormsCubit>(),
          listener: (context, state) {
            if (state.status == SavedFormsStatus.synced) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form was synced successfully')),
              );
            } else if (state.status == SavedFormsStatus.deleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form was deleted successfully')),
              );
            }
          },
          child: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, SavedFormsState state) {
    if (state.status == SavedFormsStatus.validationError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please select a form'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }

    return state.status == SavedFormsStatus.error
        ? Center(child: Text(state.error!))
        : state.status == SavedFormsStatus.loading ||
                state.status == SavedFormsStatus.syncing ||
                state.status == SavedFormsStatus.deleting
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.savedForms!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.savedForms!.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<SavedFormsCubit>()
                                          .syncSelectedForms(formID);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4E0189),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sync',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle delete button press
                                      context
                                          .read<SavedFormsCubit>()
                                          .deleteSelectedForms(formID);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4E0189),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        final savedForm = state.savedForms![index];
                        return Container(
                          color: Colors.grey[200],
                          child: ListTile(
                            leading: Checkbox(
                              value: savedForm.isSelected,
                              onChanged: (value) {
                                context
                                    .read<SavedFormsCubit>()
                                    .toggleFormSelection(savedForm.id!);
                              },
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/form_detail',
                                  arguments: savedForm);
                            },
                            title: Text("${savedForm.DataCollectionFormName} - ${savedForm.projectName}"),
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
