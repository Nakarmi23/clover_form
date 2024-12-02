import 'package:clover_form/db/models/form_option_entity.dart';
import 'package:clover_form/network/models/form_option_dto.dart';
import 'package:equatable/equatable.dart';

class FormOption extends Equatable {
  String? tagName;
  String? value;
  bool? selected;
  String? label;
  int? lineNumber;

  FormOption({
    required this.tagName,
    required this.value,
    this.selected = false,
    required this.label,
    required this.lineNumber,
  });

  factory FormOption.fromDTO(FormOptionDTO formOptionDTO) => FormOption(
        tagName: formOptionDTO.tagName,
        value: formOptionDTO.value,
        selected: formOptionDTO.selected,
        label: formOptionDTO.label,
        lineNumber: formOptionDTO.lineNumber,
      );

  factory FormOption.fromEntity(FormOptionEntity entity) => FormOption(
        tagName: entity.tagName,
        value: entity.value,
        selected: entity.selected,
        label: entity.label,
        lineNumber: entity.lineNumber,
      );

  @override
  List<Object?> get props => [
        tagName,
        value,
        selected,
        label,
        lineNumber,
      ];
}
