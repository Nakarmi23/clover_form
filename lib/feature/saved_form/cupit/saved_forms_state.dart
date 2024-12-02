part of 'saved_forms_cubit.dart';

enum SavedFormsStatus {
  loading,
  loaded,
  syncing,
  synced,
  error,
  validationError,
  deleting,
  deleted,
}

class SavedFormsState extends Equatable {
  const SavedFormsState({
    this.status = SavedFormsStatus.loading,
    this.savedForms,
    this.error,
  });

  final SavedFormsStatus status;
  final List<SavedFormModel>? savedForms;
  final String? error;

  @override
  List<Object?> get props => [status, savedForms, error];

  SavedFormsState copyWith({
    SavedFormsStatus? status,
    List<SavedFormModel>? savedForms,
    String? error,
  }) {
    return SavedFormsState(
      status: status ?? this.status,
      savedForms: savedForms ?? this.savedForms,
      error: error,
    );
  }
}
