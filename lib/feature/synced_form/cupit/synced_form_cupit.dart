import 'package:bloc/bloc.dart';
import 'package:clover_form/feature/saved_form/models/SavedFormModel.dart';
import 'package:equatable/equatable.dart';

import '../../../network/repositories/form_repository.dart';

part 'synced_form_state.dart';

class SyncedFormsCubit extends Cubit<SyncedFormsState> {
  final FormRepository formRepository;

  SyncedFormsCubit(this.formRepository) : super(const SyncedFormsState());

  void loadSavedForms(String formID) async {
    try {
      emit(state.copyWith(status: SyncedFormsStatus.loading));

      final List<SavedFormModel> savedForms =
          await formRepository.getSavedSyncedFormsDb(formID);

      if (savedForms.isNotEmpty) {
        emit(state.copyWith(
            status: SyncedFormsStatus.loaded, savedForms: savedForms));
      } else {
        emit(state.copyWith(
            status: SyncedFormsStatus.error, error: "No synced forms."));
      }
    } catch (e) {
      emit(state.copyWith(
          status: SyncedFormsStatus.error,
          error: "Failed to load synced forms."));
    }
  }
}
