import 'package:clover_form/feature/home/models/form_model_field.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "Form_Field")
class FormFieldEntity extends Equatable {
  @PrimaryKey(autoGenerate: false)
  String? id; // Updated to include formId to ensure uniqueness
  String? formId;
  String? tagName;
  String? type;
  String? name;
  String? fieldValue;
  String? label;
  String? dataLabel;
  String? classValue;
  int? lineNumber;
  bool? required;
  String? alias;
  String? max;

  FormFieldEntity({
    required this.id,
    this.formId,
    this.tagName,
    this.type,
    this.name,
    this.fieldValue,
    this.label,
    this.dataLabel,
    this.classValue,
    this.lineNumber,
    this.required,
    this.alias,
    this.max,
  });

  @override
  List<Object?> get props => [
    id,
    formId,
    tagName,
    type,
    name,
    fieldValue,
    label,
    dataLabel,
    classValue,
    lineNumber,
    required,
    alias,
    max,
  ];

  /// Factory method to create a FormFieldEntity from FormModelField, ensuring unique IDs
  factory FormFieldEntity.toEntity(FormModelField formModelField, String? formId) {
    String newId = '${formId ?? ''},${formModelField.id}';

    return FormFieldEntity(
      // id: formModelField.id,
      id: newId,
      formId: formId,
      tagName: formModelField.tagName,
      type: formModelField.type,
      name: formModelField.name,
      fieldValue: formModelField.fieldValue,
      label: formModelField.label,
      dataLabel: formModelField.dataLabel,
      classValue: formModelField.classValue,
      lineNumber: formModelField.lineNumber,
      required: formModelField.required,
      alias: formModelField.alias,
      max: formModelField.max,
    );
  }
}
