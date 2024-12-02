// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlEntryDTO _$UrlEntryDTOFromJson(Map<String, dynamic> json) => UrlEntryDTO(
      Title: json['Title'] as String,
      description: json['description'] as String,
      footer: json['footer'] as String,
      logo: json['logo'] as String,
      SiteURL: json['SiteURL'] as String,
    );

Map<String, dynamic> _$UrlEntryDTOToJson(UrlEntryDTO instance) =>
    <String, dynamic>{
      'Title': instance.Title,
      'description': instance.description,
      'footer': instance.footer,
      'logo': instance.logo,
      'SiteURL': instance.SiteURL,
    };
