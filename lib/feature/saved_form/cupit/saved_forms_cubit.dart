import 'package:bloc/bloc.dart';
import 'package:clover_form/db/models/saved_form_field_entity.dart';
import 'package:clover_form/feature/saved_form/models/SavedFormModel.dart';
import 'package:clover_form/network/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../network/repositories/form_repository.dart';

part 'saved_forms_state.dart';

class SavedFormsCubit extends Cubit<SavedFormsState> {
  final FormRepository formRepository;
  final UserRepository userRepository;

  SavedFormsCubit(this.formRepository, this.userRepository)
      : super(const SavedFormsState());

  void loadSavedForms(String formID) async {
    try {
      emit(state.copyWith(status: SavedFormsStatus.loading));

      final List<SavedFormModel> savedForms =
          await formRepository.getSavedFormsDb(formID);

      if (savedForms.isNotEmpty) {
        emit(state.copyWith(
            status: SavedFormsStatus.loaded, savedForms: savedForms));
      } else {
        emit(state.copyWith(
            status: SavedFormsStatus.error, error: "No saved forms."));
      }
    } catch (e) {
      emit(state.copyWith(
          status: SavedFormsStatus.error,
          error: "Failed to load saved forms."));
    }
  }

  void toggleFormSelection(int formId) {
    emit(state.copyWith(
      savedForms: state.savedForms?.map((form) {
        if (form.id == formId) {
          return form.copyWith(isSelected: !form.isSelected);
        }
        return form;
      }).toList(),
    ));
  }

  void syncSelectedForms(String formID) async {
    userRepository.getUserDb().then(
          (value) => {
            if (value != null)
              {
                syncSelectedFormsToApi(
                  value.auUserId,formID
                )
              }
            else
              {
                emit(
                  state.copyWith(
                      status: SavedFormsStatus.error,
                      error: "Failed to sync forms."),
                )
              }
          },
        );
  }

  void syncSelectedFormsToApi(String auUserId,String formID) async {
    try {
      emit(state.copyWith(status: SavedFormsStatus.syncing));

      final selectedForms =
          state.savedForms?.where((form) => form.isSelected).toList();

      if (selectedForms != null && selectedForms.isNotEmpty) {
        for (var form in selectedForms) {
          final List<SavedFormFieldEntity> savedFormFieldEntities =
              await formRepository.getSavedFormFieldData(form.id!);

          await formRepository.syncFormToApi(
              form.id!, auUserId,form.date, savedFormFieldEntities);

          await formRepository.updateFormStatusSynced(form.id!);
        }

        emit(state.copyWith(
          status: SavedFormsStatus.synced,
        ));
        loadSavedForms(formID);
      } else {
        emit(state.copyWith(
          status: SavedFormsStatus.validationError,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          status: SavedFormsStatus.error, error: "Failed to sync forms."));
    }
  }

  void deleteSelectedForms(String formID) async {
    try {
      emit(state.copyWith(status: SavedFormsStatus.deleting));

      final selectedForms =
          state.savedForms?.where((form) => form.isSelected).toList();

      if (selectedForms != null && selectedForms.isNotEmpty) {
        for (var form in selectedForms) {
          await formRepository.deleteFormAndFields(form.id!);
        }

        emit(state.copyWith(
          status: SavedFormsStatus.deleted,
        ));
        loadSavedForms(formID);
      } else {
        emit(state.copyWith(
          status: SavedFormsStatus.validationError,
          error: "No forms selected for deletion.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SavedFormsStatus.error,
        error: "Failed to delete forms.",
      ));
    }
  }
}
