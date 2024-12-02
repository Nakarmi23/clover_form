// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      au_user_id: json['au_user_id'] as String,
      au_first_name: json['au_first_name'] as String,
      ProvinceId: json['ProvinceId'] as String,
      DistrictId: json['DistrictId'] as String,
      PalikaId: json['PalikaId'] as String,
      ProvinceDistrictLocallId: json['ProvinceDistrictLocallId'] as String,
      EndLevelId: json['EndLevelId'] as String,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'au_user_id': instance.au_user_id,
      'au_first_name': instance.au_first_name,
      'ProvinceId': instance.ProvinceId,
      'DistrictId': instance.DistrictId,
      'PalikaId': instance.PalikaId,
      'ProvinceDistrictLocallId': instance.ProvinceDistrictLocallId,
      'EndLevelId': instance.EndLevelId,
    };
