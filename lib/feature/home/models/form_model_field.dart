import 'package:clover_form/db/models/form_field_entity.dart';
import 'package:clover_form/network/models/form_field_dto.dart';
import 'package:equatable/equatable.dart';

import 'form_option.dart';

class FormModelField extends Equatable {
  FormModelField({
    this.tagName,
    this.type,
    this.name,
    this.id,
    this.fieldValue,
    this.label,
    this.dataLabel,
    this.classValue,
    this.lineNumber,
    this.required,
    this.alias,
    this.options,
    this.max,
    this.formValue,
    this.fieldID,
    this.isInvalid = false,
  });

  String? tagName;
  String? type;
  String? name;
  String? id;
  String? fieldValue;
  String? label;
  String? dataLabel;
  String? classValue;
  int? lineNumber;
  bool? required;
  String? alias;
  List<FormOption>? options;
  String? max;
  String? formValue;
  int? fieldID;
  bool? isInvalid;

  factory FormModelField.fromDTO(FormFieldDTO formFieldDTO) => FormModelField(
        tagName: formFieldDTO.tagName,
        type: formFieldDTO.type,
        name: formFieldDTO.name,
        id: formFieldDTO.id,
        fieldValue: formFieldDTO.fieldValue,
        label: formFieldDTO.label,
        dataLabel: formFieldDTO.dataLabel,
        classValue: formFieldDTO.classValue,
        lineNumber: formFieldDTO.lineNumber,
        required: formFieldDTO.required,
        options: formFieldDTO.options
            ?.map((value) => FormOption.fromDTO(value))
            .toList(),
        alias: formFieldDTO.alias,
      );

  @override
  List<Object?> get props => [
        tagName,
        type,
        name,
        id,
        fieldValue,
        label,
        dataLabel,
        classValue,
        lineNumber,
        required,
        alias,
        options,
        max,
        formValue,
        fieldID,
        isInvalid,
      ];

  factory FormModelField.fromEntity(
          FormFieldEntity entity, List<FormOption>? optionEntities) =>
      FormModelField(
        tagName: entity.tagName,
        type: entity.type,
        name: entity.name,
        id: entity.id,
        fieldValue: entity.fieldValue,
        label: entity.label,
        dataLabel: entity.dataLabel,
        classValue: entity.classValue,
        lineNumber: entity.lineNumber,
        required: entity.required,
        options: optionEntities,
        alias: entity.alias,
      );

  FormModelField copyWith({
    String? tagName,
    String? type,
    String? name,
    String? id,
    String? fieldValue,
    String? label,
    String? dataLabel,
    String? classValue,
    int? lineNumber,
    bool? required,
    String? alias,
    List<FormOption>? options,
    String? max,
    String? formValue,
    int? fieldID,
    bool? isInvalid,
  }) {
    return FormModelField(
      tagName: tagName ?? this.tagName,
      type: type ?? this.type,
      name: name ?? this.name,
      id: id ?? this.id,
      fieldValue: fieldValue ?? this.fieldValue,
      label: label ?? this.label,
      dataLabel: dataLabel ?? this.dataLabel,
      classValue: classValue ?? this.classValue,
      lineNumber: lineNumber ?? this.lineNumber,
      required: required ?? this.required,
      alias: alias ?? this.alias,
      options: options ?? this.options,
      max: max ?? this.max,
      formValue: formValue ?? this.formValue,
      fieldID: fieldID ?? this.fieldID,
      isInvalid: isInvalid ?? this.isInvalid,
    );
  }
}
