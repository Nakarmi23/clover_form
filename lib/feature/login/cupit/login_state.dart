part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

final class LoginState extends Equatable {
  final LoginStatus status;
  final User? user;
  final String? errorMsg;

  const LoginState(
      {this.status = LoginStatus.initial, this.user, this.errorMsg});

  LoginState copyWith({LoginStatus? status, User? user, String? errorMsg}) {
    return LoginState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [status, user, errorMsg];
}
