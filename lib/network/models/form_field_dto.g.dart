// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldDTO _$FormFieldDTOFromJson(Map<String, dynamic> json) => FormFieldDTO(
      tagName: json['tagName'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      fieldValue: json['value'] as String?,
      label: json['label'] as String?,
      dataLabel: json['data-label'] as String?,
      classValue: json['class'] as String?,
      lineNumber: (json['lineNumber'] as num?)?.toInt(),
      required: json['required'] as bool?,
      alias: json['alias'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => FormOptionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      max: json['max'] as String?,
    );

Map<String, dynamic> _$FormFieldDTOToJson(FormFieldDTO instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'type': instance.type,
      'name': instance.name,
      'id': instance.id,
      'value': instance.fieldValue,
      'label': instance.label,
      'data-label': instance.dataLabel,
      'class': instance.classValue,
      'lineNumber': instance.lineNumber,
      'required': instance.required,
      'alias': instance.alias,
      'options': instance.options,
      'max': instance.max,
    };
