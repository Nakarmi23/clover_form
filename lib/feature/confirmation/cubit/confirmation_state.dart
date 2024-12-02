part of 'confirmation_cubit.dart';

enum ConfirmationStatus { initial, success, failure }

final class ConfirmationState extends Equatable {
  final ConfirmationStatus status;
  final UrlEntry? urlEntry;
  final String? errorMsg;

  const ConfirmationState(
      {this.status = ConfirmationStatus.initial, this.urlEntry, this.errorMsg});

  ConfirmationState copyWith(
      {ConfirmationStatus? status, UrlEntry? urlEntry, String? errorMsg}) {
    return ConfirmationState(
        status: status ?? this.status,
        urlEntry: urlEntry ?? this.urlEntry,
        errorMsg: errorMsg ?? this.errorMsg);
  }

  @override
  List<Object?> get props => [status, urlEntry, errorMsg];
}
