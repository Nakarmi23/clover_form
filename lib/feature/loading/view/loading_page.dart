import 'package:clover_form/feature/loading/cubit/loading_cubit.dart';
import 'package:clover_form/feature/loading/view/loading_view.dart';
import 'package:clover_form/network/repositories/url_entry_repository.dart';
import 'package:clover_form/network/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UrlEntryRepository>(
            create: (context) => UrlEntryRepository()),
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
      ],
      child: BlocProvider(
          create: (context) => LoadingCubit(
              urlEntryRepository:
                  RepositoryProvider.of<UrlEntryRepository>(context),
              userRepository: RepositoryProvider.of<UserRepository>(context)),
          child: BlocListener<LoadingCubit, LoadingState>(
            listener: (context, state) => addAlertListener(
              context,
              state,
            ),
            child: const LoadingView(),
          )),
    );
  }

  void addAlertListener(BuildContext context, LoadingState state) {
    if (state.status == LoadingStatus.initial) {
      Navigator.popAndPushNamed(context, '/urlEntry');
    } else if (state.status == LoadingStatus.siteInfo) {
      Navigator.popAndPushNamed(context, '/login');
    } else if (state.status == LoadingStatus.logged) {
      Navigator.popAndPushNamed(context, '/home');
    }
  }
}
