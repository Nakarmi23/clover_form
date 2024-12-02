import 'package:clover_form/feature/form_detail/cubit/form_detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repositories/form_repository.dart';
import 'from_detail_view.dart';

class FormDetailPage extends StatelessWidget {
  final String title;
  final String formID;
  final int id;

  const FormDetailPage(
      {super.key, required this.title, required this.formID, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FormRepository>(
            create: (context) => FormRepository()),
      ],
      child: BlocProvider(
        create: (context) => FormDetailCubit(
          formRepository: RepositoryProvider.of<FormRepository>(context),
          id: id,
          formId: formID,
          formName: title,
        ),
        child: FormDetailView(
          formID: formID,
          title: title,
        ),
      ),
    );
  }
}
