// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nagapaga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nagapaga _$NagapagaFromJson(Map<String, dynamic> json) => Nagapaga(
      napaGapaId: json['NapaGapaId'] as String,
      napaGapaNE: json['NapaGapaNE'] as String?,
      napaGapaEN: json['NapaGapaEN'] as String,
      districtId: json['DistrictId'] as String,
    );

Map<String, dynamic> _$NagapagaToJson(Nagapaga instance) => <String, dynamic>{
      'NapaGapaId': instance.napaGapaId,
      'NapaGapaNE': instance.napaGapaNE,
      'NapaGapaEN': instance.napaGapaEN,
      'DistrictId': instance.districtId,
    };
