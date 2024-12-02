import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:clover_form/db/models/saved_form_entity.dart';
import 'package:clover_form/feature/home/models/form_model_field.dart';
import 'package:clover_form/network/repositories/form_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../db/models/saved_form_field_entity.dart';
import '../../../network/models/district.dart';
import '../../../network/models/nagapaga.dart';
import '../../../network/models/province.dart';

part 'form_detail_state.dart';

class FormDetailCubit extends Cubit<FormDetailState> {
  final FormRepository formRepository;
  int id = 0;
  final String formId;
  final String formName;
  late final List<Province> provinces;
  late final List<District> districts;
  late final List<Nagapaga> nagapagas;

  FormDetailCubit({
    required this.formId,
    required this.formName,
    required this.formRepository,
    required this.id,
  }) : super(const FormDetailState());

  Future<void> loadInitialData(String formID) async {
    emit(
      state.copyWith(status: FormDetailStatus.loading),
    );

    List<Province> loadedProvinces =
        await loadProvincesFromJsonAsset('json/adbprovince.json');
    provinces = loadedProvinces
      ..sort((a, b) => a.provinceName.compareTo(b.provinceName));

    List<District> loadedDistricts =
        await loadDistrictsFromJsonAsset('json/adbdistrict.json');
    districts = loadedDistricts
      ..sort((a, b) => a.districtName.compareTo(b.districtName));

    List<Nagapaga> loadedNagapagas =
        await loadNagapasFromJsonAsset('json/adbnapagapa.json');
    nagapagas = loadedNagapagas
      ..sort((a, b) => a.napaGapaEN.compareTo(b.napaGapaEN));

    getFormModelFieldsDb(formID);
  }

  void getFormModelFieldsDb(String formID) async {
    formRepository.getFormModelFieldsDb(formID).then(
      (value) {
        if (id == 0) {
          onSuccessful(value);
        } else {
          fetchSavedFieldValues(id, value);
        }
      },
    ).onError(
      (error, stackTrace) {
        emit(
          state.copyWith(
            status: FormDetailStatus.failed,
            errorMsg: "Something went wrong. Please try again later.",
          ),
        );
      },
    );
  }

  void onSuccessful(List<FormModelField>? formFields) {
    emit(
      state.copyWith(
        status: FormDetailStatus.success,
        formFields: formFields,
      ),
    );
  }

  void fetchSavedFieldValues(int id, List<FormModelField>? formFields) {
    formRepository.getSavedFormFieldData(id).then(
      (savedFieldValues) {
        formFields?.forEach(
          (element) {
            final matchingValue = savedFieldValues.firstWhere(
              (value) => element.id == value.id,
              orElse: () => SavedFormFieldEntity(),
            );

            element.formValue = matchingValue.formValue;
            element.fieldID = matchingValue.fieldId;
          },
        );
        onSuccessful(formFields);
      },
    ).onError(
      (error, stackTrace) {
        emit(
          state.copyWith(
            status: FormDetailStatus.failed,
            errorMsg:
                "Failed to fetch saved field values. Please try again. $error",
          ),
        );
      },
    );
  }

  void updateFormFieldValue(int index, String value) {
    final List<FormModelField> updatedFormFields = List.from(state.formFields);

    final FormModelField updatedField =
        updatedFormFields[index].copyWith(formValue: value);
    updatedFormFields[index] = updatedField;

    emit(
      state.copyWith(formFields: updatedFormFields),
    );
  }

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  List<FormModelField>? areAllRequiredFieldsFilled(
      List<FormModelField> formFields) {
    bool allFilled = true;
    for (var field in formFields) {
      if (field.required == true && field.formValue == null) {
        field.isInvalid = true;
        allFilled = false;
      }
    }

    if (allFilled == false) {
      return formFields;
    } else {
      return null;
    }
  }

  void submitForm() async {
    var list = areAllRequiredFieldsFilled(state.formFields);
    if (list == null) {
      saveForm();
    } else {
      emit(
        state.copyWith(
          status: FormDetailStatus.validationError,
          formFields: list,
          errorMsg: "Please fill in all required fields.",
        ),
      );

      emit(state.copyWith(status: FormDetailStatus.initial));
    }
  }

  // String getProjectName() {
  //   String? projectName;
  //   if (state.formFields.isNotEmpty) {
  //     projectName = state.formFields
  //         .firstWhere(
  //             (element) => element.label?.toLowerCase() == "project name",
  //         orElse: () => FormModelField(
  //             label: "project name-${DateTime.now().toIso8601String()} ",
  //             formValue: null) // or provide a default value
  //     )
  //         .formValue;
  //   }
  //   if (projectName?.isNotEmpty == true) {
  //     return projectName!;
  //   } else {
  //     return "";
  //   }
  // }

  String getProjectName() {
    String? projectName = state.formFields
        .firstWhere((element) => element.label?.toLowerCase() == "project name")
        .formValue;
    if (projectName?.isNotEmpty == true) {
      return projectName!;
    } else {
      return "";
    }
  }

  void saveForm() {
    if (id == 0) {
      String date = getCurrentDate();

      SavedFormEntity savedFormEntity = SavedFormEntity(
          DataCollectionFormId: formId,
          DataCollectionFormName: formName,
          projectName: getProjectName(),
          date: date);

      formRepository
          .saveFormData(savedFormEntity)
          .then((value) => saveFormField(value))
          .onError(
        (error, stackTrace) {
          emit(
            state.copyWith(
              status: FormDetailStatus.failed,
              errorMsg: "Something went wrong. Please try again later.",
            ),
          );
        },
      );
    } else {
      formRepository
          .updateFormTitle(id, getProjectName())
          .then((value) => saveFormField(id))
          .onError(
        (error, stackTrace) {
          emit(
            state.copyWith(
              status: FormDetailStatus.failed,
              errorMsg: "Something went wrong. Please try again later.",
            ),
          );
        },
      );
    }
  }

  void saveFormField(int id) async {
    var list = getValues(state.formFields, id);

    formRepository
        .saveFormFieldData(list)
        .then(
          (value) => emit(
            state.copyWith(
              status: FormDetailStatus.saved,
            ),
          ),
        )
        .onError(
      (error, stackTrace) {
        emit(
          state.copyWith(
            status: FormDetailStatus.failed,
            errorMsg: "Something went wrong. Please try again later.",
          ),
        );
      },
    );
  }

  List<SavedFormFieldEntity> getValues(
      List<FormModelField> formFields, int savedFormID) {
    List<SavedFormFieldEntity> savedFormFields = [];

    for (var field in formFields) {
      var label = field.label;
      if (field.dataLabel == "GetAdministrativeLocation") {
        label = "Select Administrative location";
      }

      savedFormFields.add(
        SavedFormFieldEntity(
          id: field.id,
          fieldId: field.fieldID,
          savedFormId: savedFormID,
          formValue: field.formValue,
          label: label,
        ),
      );
    }

    return savedFormFields;
  }

  Future<List<Province>> loadProvincesFromJsonAsset(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Province>((json) => Province.fromJson(json)).toList();
  }

  Future<List<District>> loadDistrictsFromJsonAsset(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<District>((json) => District.fromJson(json)).toList();
  }

  Future<List<Nagapaga>> loadNagapasFromJsonAsset(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Nagapaga>((json) => Nagapaga.fromJson(json)).toList();
  }
}
