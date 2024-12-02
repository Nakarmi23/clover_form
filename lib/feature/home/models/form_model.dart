import 'package:clover_form/db/models/form_entity.dart';
import 'package:clover_form/feature/home/models/form_model_field.dart';
import 'package:clover_form/network/models/form_dto.dart';
import 'package:equatable/equatable.dart';

class FormModel extends Equatable {
  FormModel({
    required this.DataCollectionFormId,
    required this.DataCollectionFormName,
    this.DataCollectionFormFields,
    // required this.DataCollectionFormHtlm,
    required this.DataCollectionFormSubmissionURL,
    required this.FormType,
  });

  final String DataCollectionFormId;
  final String DataCollectionFormName;
  List<FormModelField>? DataCollectionFormFields;
  final String FormType;

  // final String DataCollectionFormHtlm;

  final String DataCollectionFormSubmissionURL;

  factory FormModel.fromDTO(FormDTO form, List<FormModelField>? formField) =>
      FormModel(
        DataCollectionFormId: form.DataCollectionFormId,
        DataCollectionFormName: form.DataCollectionFormName,
        DataCollectionFormFields: formField,
        // DataCollectionFormHtlm: form.DataCollectionFormHtlm,
        DataCollectionFormSubmissionURL: form.DataCollectionFormSubmissionURL,
        FormType: form.FormType,
      );

  factory FormModel.fromEntity(FormEntity entity) => FormModel(
        DataCollectionFormId: entity.DataCollectionFormId,
        DataCollectionFormName: entity.DataCollectionFormName,
        DataCollectionFormSubmissionURL: entity.DataCollectionFormSubmissionURL,
        FormType: entity.FormType,
      );

  @override
  List<Object?> get props => [
        DataCollectionFormId,
        DataCollectionFormName,
        DataCollectionFormFields,
        // DataCollectionFormHtlm,
        DataCollectionFormSubmissionURL
      ];
}
