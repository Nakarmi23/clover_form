import 'package:json_annotation/json_annotation.dart';

part 'nagapaga.g.dart';

@JsonSerializable()
class Nagapaga {
  @JsonKey(name: 'NapaGapaId')
  final String napaGapaId;
  @JsonKey(name: 'NapaGapaNE')
  final String? napaGapaNE;
  @JsonKey(name: 'NapaGapaEN')
  final String napaGapaEN;
  @JsonKey(name: 'DistrictId')
  final String districtId;

  Nagapaga({
    required this.napaGapaId,
    required this.napaGapaNE,
    required this.napaGapaEN,
    required this.districtId,
  });

  factory Nagapaga.fromJson(Map<String, dynamic> json) =>
      _$NagapagaFromJson(json);

  Map<String, dynamic> toJson() => _$NagapagaToJson(this);
}