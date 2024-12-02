import 'package:clover_form/db/models/url_entry_entity.dart';
import 'package:clover_form/network/models/url_entry_dto.dart';
import 'package:equatable/equatable.dart';

class UrlEntry extends Equatable {
  const UrlEntry(
      {required this.title, required this.description, required this.footer, required this.iconPath, required this.siteUrl});

  final String title;
  final String description;
  final String footer;
  final String iconPath;
  final String siteUrl;

  factory UrlEntry.fromDTO(UrlEntryDTO urlEntryDTO) => UrlEntry(
      title: urlEntryDTO.Title,
      description: urlEntryDTO.description,
      footer: urlEntryDTO.footer,
      iconPath: urlEntryDTO.logo,
      siteUrl: urlEntryDTO.SiteURL);

  factory UrlEntry.fromEntity(UrlEntryEntity urlEntryEntity) => UrlEntry(
      title: urlEntryEntity.title,
      description: urlEntryEntity.description,
      footer: urlEntryEntity.footer,
      iconPath: urlEntryEntity.iconPath,
      siteUrl: urlEntryEntity.siteUrl);

  @override
  List<Object?> get props => [title, description,footer, iconPath,siteUrl];
}
