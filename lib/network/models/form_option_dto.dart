import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_option_dto.g.dart';

@JsonSerializable()
class FormOptionDTO extends Equatable {
  String? tagName;
  String? value;
  bool? selected;
  String? label;
  int? lineNumber;

  FormOptionDTO({
     this.tagName,
     this.value,
    this.selected,
     this.label,
     this.lineNumber,
  });

  factory FormOptionDTO.fromJson(Map<String, dynamic> json) =>
      _$FormOptionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FormOptionDTOToJson(this);

  @override
  List<Object?> get props => [
    tagName,
    value,
    selected,
    label,
    lineNumber,
  ];
}
