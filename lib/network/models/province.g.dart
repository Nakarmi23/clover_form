// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) => Province(
      provinceId: json['ProvinceId'] as String,
      provinceNameNP: json['ProvinceNameNP'] as String,
      provinceName: json['ProvinceName'] as String,
    );

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'ProvinceId': instance.provinceId,
      'ProvinceNameNP': instance.provinceNameNP,
      'ProvinceName': instance.provinceName,
    };
