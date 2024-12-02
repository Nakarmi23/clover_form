part of 'synced_form_cupit.dart';

enum SyncedFormsStatus {
  loading,
  loaded,
  error,
}

class SyncedFormsState extends Equatable {
  const SyncedFormsState({
    this.status = SyncedFormsStatus.loading,
    this.savedForms,
    this.error,
  });

  final SyncedFormsStatus status;
  final List<SavedFormModel>? savedForms;
  final String? error;

  @override
  List<Object?> get props => [status, savedForms, error];

  SyncedFormsState copyWith({
    SyncedFormsStatus? status,
    List<SavedFormModel>? savedForms,
    String? error,
  }) {
    return SyncedFormsState(
      status: status ?? this.status,
      savedForms: savedForms ?? this.savedForms,
      error: error,
    );
  }
}
