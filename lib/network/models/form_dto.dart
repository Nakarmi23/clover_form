import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'form_field_dto.dart';

part 'form_dto.g.dart';

@JsonSerializable()
class FormDTO extends Equatable {
  FormDTO({
    required this.DataCollectionFormId,
    required this.DataCollectionFormName,
    required this.DataCollectionFormFields,
    // required this.DataCollectionFormHtlm,
    required this.DataCollectionFormSubmissionURL,
    this.formFields,
    required this.FormType,
    this.ProjectListFetchURL,
  });

  final String DataCollectionFormId;
  final String DataCollectionFormName;
  final String DataCollectionFormFields;
  final String FormType;
  // final String DataCollectionFormHtlm;
  final String DataCollectionFormSubmissionURL;
  List<FormFieldDTO>? formFields;
  final String? ProjectListFetchURL;

  @override
  List<Object?> get props => [
        DataCollectionFormId,
        DataCollectionFormName,
        DataCollectionFormFields,
        // DataCollectionFormHtlm,
        DataCollectionFormSubmissionURL,
        formFields,
        FormType,
        ProjectListFetchURL,
      ];

  factory FormDTO.fromJson(Map<String, dynamic> json) =>
      _$FormDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FormDTOToJson(this);
}
