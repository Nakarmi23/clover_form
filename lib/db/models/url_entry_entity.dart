import 'package:floor/floor.dart';

import '../../feature/url_entry/models/url_entry.dart';
import '../../network/models/url_entry_dto.dart';

@Entity(tableName: "UrlEntry")
class UrlEntryEntity {
  const UrlEntryEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.footer,
      required this.iconPath,
      required this.siteUrl});

  @primaryKey
  final int id;
  final String title;
  final String description;
  final String footer;
  final String iconPath;
  final String siteUrl;

  factory UrlEntryEntity.fromDTO(UrlEntryDTO urlEntryDTO) => UrlEntryEntity(
      id: 1,
      title: urlEntryDTO.Title,
      description: urlEntryDTO.description,
      footer: urlEntryDTO.footer,
      iconPath: urlEntryDTO.logo,
      siteUrl: urlEntryDTO.SiteURL);

  factory UrlEntryEntity.fromModel(UrlEntry urlEntry) => UrlEntryEntity(
      id: 1,
      title: urlEntry.title,
      description: urlEntry.description,
      footer: urlEntry.footer,
      iconPath: urlEntry.iconPath,
      siteUrl: urlEntry.siteUrl);
}
