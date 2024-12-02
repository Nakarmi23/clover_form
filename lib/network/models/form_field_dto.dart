import 'package:clover_form/network/models/form_option_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_field_dto.g.dart';

@JsonSerializable()
class FormFieldDTO extends Equatable {
  FormFieldDTO({
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
  });

  String? tagName;
  String? type;
  String? name;
  String? id;
  @JsonKey(name: "value")
  String? fieldValue;
  String? label;
  @JsonKey(name: "data-label")
  String? dataLabel;
  @JsonKey(name: "class")
  String? classValue;
  int? lineNumber;
  bool? required;
  String? alias;
  List<FormOptionDTO>? options;
  String? max;

  @override
  List<Object?> get props => [];

  factory FormFieldDTO.fromJson(Map<String, dynamic> json) =>
      _$FormFieldDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FormFieldDTOToJson(this);
}
