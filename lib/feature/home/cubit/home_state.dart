part of 'home_cubit.dart';

enum HomeStatus { initial, loggedOut, reset }

enum FormStatus { initial, loading, success, failed }

final class HomeState extends Equatable {
  final HomeStatus status;
  final FormStatus formStatus;
  final List<FormModel> forms;
  final String errorMsg;

  const HomeState({
    this.status = HomeStatus.initial,
    this.formStatus = FormStatus.initial,
    this.forms = const <FormModel>[],
    this.errorMsg = "",
  });

  HomeState copyWith({
    HomeStatus? status,
    FormStatus? formStatus,
    List<FormModel>? forms,
    String? errorMsg,
  }) {
    return HomeState(
        status: status ?? this.status,
        formStatus: formStatus ?? this.formStatus,
        forms: forms ?? this.forms,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [status, formStatus];
}
