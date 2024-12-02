// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      districtId: json['DistrictId'] as String,
      districtName: json['DistrictName'] as String,
      provinceId: json['ProvinceId'] as String,
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'DistrictId': instance.districtId,
      'DistrictName': instance.districtName,
      'ProvinceId': instance.provinceId,
    };
