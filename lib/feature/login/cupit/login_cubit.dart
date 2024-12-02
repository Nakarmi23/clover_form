import 'package:bloc/bloc.dart';
import 'package:clover_form/db/models/user_entity.dart';
import 'package:clover_form/feature/login/models/user.dart';
import 'package:equatable/equatable.dart';

import '../../../network/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;

  LoginCubit({required this.userRepository}) : super(const LoginState());

  void updateState() {
    emit(state.copyWith(status: LoginStatus.initial));
  }

  void saveUser(User user) {
    userRepository
        .saveUser(UserEntity.fromModel(user))
        .then(
          (value) => emit(
            state.copyWith(
              status: LoginStatus.success,
              user: user,
            ),
          ),
        )
        .onError(
          (error, stackTrace) => emit(
            state.copyWith(
                status: LoginStatus.failure,
                errorMsg:
                    "Something went wrong. Please try again later in db."),
          ),
        );
  }

  void login(String userName, String password) {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );
    userRepository
        .login(userName, password)
        .then(
          (value) => saveUser(value),
        )
        .onError(
          (error, stackTrace) => emit(
            state.copyWith(
                status: LoginStatus.failure,
                errorMsg: "Something went wrong. Please try again later."),
          ),
        );
  }
}
