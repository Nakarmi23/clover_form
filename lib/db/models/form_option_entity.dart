import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../feature/home/models/form_option.dart';


@Entity(tableName: "Form_Field_Option")
class FormOptionEntity extends Equatable {
  @PrimaryKey(autoGenerate: false)
  String labelFormFieldId;
  String? label;
  String? formFieldId;
  String? tagName;
  String? value;
  bool? selected;
  int? lineNumber;

  FormOptionEntity({
    required this.labelFormFieldId,
    this.formFieldId,
    required this.tagName,
    required this.value,
    this.selected = false,
    required this.label,
    required this.lineNumber,
  });

  @override
  List<Object?> get props => [
        tagName,
        value,
        selected,
        label,
        lineNumber,
      ];

  factory FormOptionEntity.toEntity(
          FormOption formOption, String? formFieldId) =>
      FormOptionEntity(
        labelFormFieldId: "${formOption.label}_$formFieldId",
        formFieldId: formFieldId,
        tagName: formOption.tagName,
        value: formOption.value,
        selected: formOption.selected,
        label: formOption.label,
        lineNumber: formOption.lineNumber,
      );
}
