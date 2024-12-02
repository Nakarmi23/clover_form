import 'package:clover_form/feature/login/cupit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/login_button.dart';
import '../widgets/login_text_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final userNameController = TextEditingController();
  final pwdController = TextEditingController();

  String get _userName => userNameController.text;

  String get _pwd => pwdController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 39, right: 26),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              LoginTextField(
                controller: userNameController,
                hint: "Username",
                leadingIcon: Icons.person,
                isPassword: false,
              ),
              const SizedBox(
                height: 22,
              ),
              LoginTextField(
                controller: pwdController,
                hint: "Password",
                leadingIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(
                height: 103,
              ),
              LoginButton(
                onButtonPressed: () =>
                    context.read<LoginCubit>().login(_userName, _pwd),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
