import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'url_entry_dto.g.dart';

@JsonSerializable()
class UrlEntryDTO extends Equatable {
  const UrlEntryDTO(
      {required this.Title,
      required this.description,
      required this.footer,
      required this.logo,
      required this.SiteURL});

  final String Title;
  final String description;
  final String footer;
  final String logo;
  final String SiteURL;

  @override
  List<Object?> get props => [Title, description, footer, logo, SiteURL];

  factory UrlEntryDTO.fromJson(Map<String, dynamic> json) =>
      _$UrlEntryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UrlEntryDTOToJson(this);
}
