// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormDTO _$FormDTOFromJson(Map<String, dynamic> json) => FormDTO(
      DataCollectionFormId: json['DataCollectionFormId'] as String,
      DataCollectionFormName: json['DataCollectionFormName'] as String,
      DataCollectionFormFields: json['DataCollectionFormFields'] as String,
      DataCollectionFormSubmissionURL:
          json['DataCollectionFormSubmissionURL'] as String,
      formFields: (json['formFields'] as List<dynamic>?)
          ?.map((e) => FormFieldDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FormDTOToJson(FormDTO instance) => <String, dynamic>{
      'DataCollectionFormId': instance.DataCollectionFormId,
      'DataCollectionFormName': instance.DataCollectionFormName,
      'DataCollectionFormFields': instance.DataCollectionFormFields,
      'DataCollectionFormSubmissionURL':
          instance.DataCollectionFormSubmissionURL,
      'formFields': instance.formFields,
      'ProjectListFetchURL': instance.ProjectListFetchURL,
    };
