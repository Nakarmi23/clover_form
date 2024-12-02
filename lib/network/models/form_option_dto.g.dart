// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_option_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormOptionDTO _$FormOptionDTOFromJson(Map<String, dynamic> json) =>
    FormOptionDTO(
      tagName: json['tagName'] as String?,
      value: json['value'] as String?,
      selected: json['selected'] as bool?,
      label: json['label'] as String?,
      lineNumber: (json['lineNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FormOptionDTOToJson(FormOptionDTO instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'value': instance.value,
      'selected': instance.selected,
      'label': instance.label,
      'lineNumber': instance.lineNumber,
    };
