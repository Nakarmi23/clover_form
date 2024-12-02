import 'package:clover_form/feature/home/cubit/home_cubit.dart';
import 'package:clover_form/network/repositories/form_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repositories/url_entry_repository.dart';
import '../../../network/repositories/user_repository.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UrlEntryRepository>(
            create: (context) => UrlEntryRepository()),
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
        RepositoryProvider<FormRepository>(
            create: (context) => FormRepository()),
      ],
      child: BlocProvider(
          create: (context) => HomeCubit(
                urlEntryRepository:
                    RepositoryProvider.of<UrlEntryRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
                formRepository: RepositoryProvider.of<FormRepository>(context),
              ),
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) => addAlertListener(
              context,
              state,
            ),
            child: const HomeView(),
          )),
    );
  }

  void addAlertListener(BuildContext context, HomeState state) {
    if (state.status == HomeStatus.loggedOut) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    } else if (state.status == HomeStatus.reset) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/urlEntry', (Route<dynamic> route) => false);
    }
  }
}
