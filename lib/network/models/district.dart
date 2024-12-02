import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  @JsonKey(name: 'DistrictId')
  final String districtId;
  @JsonKey(name: 'DistrictName')
  final String districtName;
  @JsonKey(name: 'ProvinceId')
  final String provinceId;

  District({
    required this.districtId,
    required this.districtName,
    required this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
