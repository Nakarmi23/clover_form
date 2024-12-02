import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/form_detail_cubit.dart';
import 'form_detail_child.dart';

class FormDetailView extends StatelessWidget {
  final String formID;
  final String title;

  const FormDetailView({super.key, required this.formID, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocListener<FormDetailCubit, FormDetailState>(
        listener: (context, state) {
          if (state.status == FormDetailStatus.saved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form has been saved.')),
            );
            Navigator.pop(context);
          } else if (state.status == FormDetailStatus.validationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMsg)),
            );
          }
        },
        child: BlocBuilder<FormDetailCubit, FormDetailState>(
          bloc: BlocProvider.of<FormDetailCubit>(context)
            ..loadInitialData(formID),
          builder: (context, state) {
            if (state.status == FormDetailStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FormDetailChild(fields: state.formFields, formID: formID);
            }
          },
        ),
      ),
    );
  }
}
