import 'package:json_annotation/json_annotation.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  @JsonKey(name: 'ProvinceId')
  final String provinceId;
  @JsonKey(name: 'ProvinceNameNP')
  final String provinceNameNP;
  @JsonKey(name: 'ProvinceName')
  final String provinceName;

  Province({
    required this.provinceId,
    required this.provinceNameNP,
    required this.provinceName,
  });

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
