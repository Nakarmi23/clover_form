import 'package:bloc/bloc.dart';
import 'package:clover_form/db/models/form_field_entity.dart';
import 'package:clover_form/feature/home/models/form_model.dart';
import 'package:clover_form/network/repositories/form_repository.dart';
import 'package:clover_form/network/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../db/models/form_entity.dart';
import '../../../db/models/form_option_entity.dart';
import '../../../network/repositories/url_entry_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UrlEntryRepository urlEntryRepository;
  final UserRepository userRepository;
  final FormRepository formRepository;

  HomeCubit(
      {required this.urlEntryRepository,
      required this.userRepository,
      required this.formRepository})
      : super(const HomeState());

  void logOut() {
    userRepository.deleteUserDb().then(
          (value) => emit(
            state.copyWith(status: HomeStatus.loggedOut),
          ),
        );
  }

  void reset() async {
    userRepository.deleteUserDb().then(
          (value) => urlEntryRepository.deleteSiteInfoDb().then(
                (value) => emit(
                  state.copyWith(status: HomeStatus.reset),
                ),
              ),
        );
  }

  void getForms(String formId, String userId) async {
    getFormsDb(formId, userId);
  }

  Future<bool> hasInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  void getFormApi(String formId, String userId) async {
    emit(
      state.copyWith(formStatus: FormStatus.loading),
    );
    formRepository.getForms(formId, userId).then(
          (value) => saveForm(value)
              .then(
                (_) => onSuccess(value),
              )
              .onError(
                (error, stackTrace) => onFailure(),
              ),
        );
  }

  void onSuccess(List<FormModel>? forms) {
    emit(
      state.copyWith(
        formStatus: FormStatus.success,
        forms: forms,
      ),
    );
  }

  void onFailure() {
    emit(
      state.copyWith(
        formStatus: FormStatus.failed,
        errorMsg: "Something went wrong. Please try again later.",
      ),
    );
  }

  void getFormsDb(String formId, String userId) async {
    formRepository.getFormsDb().then(
      (value) {
        if (value.isEmpty) {
          getFormApi(formId, userId);
        } else {
          onSuccess(value);
        }
      },
    ).onError(
      (error, stackTrace) {
        hasInternet().then((value) {
          if (value == true) {
            getFormApi(formId, userId);
          } else {
            onFailure();
          }
        });
      },
    );
  }

  Future<void> saveForm(List<FormModel> forms) async {
    // Create lists to store entities
    List<FormFieldEntity> formFieldEntities = [];
    List<FormOptionEntity> formOptionEntities = [];

    // Convert each form model into its corresponding entity
    List<FormEntity> formEntities = forms.map((form) {
      // Check if DataCollectionFormFields is not null
      if (form.DataCollectionFormFields != null) {
        // Map form fields to entities and process options if available
        for (var formField in form.DataCollectionFormFields!) {
          // Check if formField options are not null
          if (formField.options != null) {
            // Convert options to entities and add them to the options list
            formOptionEntities.addAll(
              formField.options!.map(
                    (formOption) => FormOptionEntity.toEntity(formOption, formField.id),
              ),
            );
          }
          // Convert form fields to entities and add to the fields list
          formFieldEntities.add(
            FormFieldEntity.toEntity(formField, form.DataCollectionFormId),
          );
        }
      }
      // Convert form to entity and return
      return FormEntity.toEntity(form);
    }).toList();

    // Save forms, form fields, and form options using the repository
    await formRepository.saveForms(formEntities);
    await formRepository.saveFormFields(formFieldEntities);
    await formRepository.saveFormOptions(formOptionEntities);
  }
}
