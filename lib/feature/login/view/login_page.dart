import 'package:clover_form/feature/login/view/login_view.dart';
import 'package:clover_form/network/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/alerts.dart';
import '../cupit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => LoginCubit(
            userRepository: RepositoryProvider.of<UserRepository>(context)),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) => addAlertListener(
              context, state, () => {context.read<LoginCubit>().updateState()}),
          child: LoginView(),
        ),
      ),
    );
  }

  void addAlertListener(
      BuildContext context, LoginState state, Function updateState) {
    if (state.status == LoginStatus.failure) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return Alerts.showAlert("Error Message", state.errorMsg ?? "");
          }).then((value) => {updateState()});
    } else if (state.status == LoginStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (Route<dynamic> route) => false,
      );
    } else if (state.status == LoginStatus.loading) {
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
