import 'package:clover_form/feature/saved_form/view/saved_form_child.dart';
import 'package:clover_form/network/repositories/form_repository.dart';
import 'package:clover_form/network/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cupit/saved_forms_cubit.dart';

class SavedFormView extends StatelessWidget {
  const SavedFormView({super.key, required this.formID});

  final String formID;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FormRepository>(
          create: (context) => FormRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => SavedFormsCubit(
          RepositoryProvider.of<FormRepository>(context),
          RepositoryProvider.of<UserRepository>(context),
        ),
        child:  SavedFormChild(formID: formID,),
      ),
    );
  }
}
