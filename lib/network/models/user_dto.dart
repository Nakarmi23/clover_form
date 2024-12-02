import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO extends Equatable {
  String au_user_id;
  String au_first_name;
  String ProvinceId;
  String DistrictId;
  String PalikaId;
  String ProvinceDistrictLocallId;
  String EndLevelId;

  UserDTO(
      {required this.au_user_id,
      required this.au_first_name,
      required this.ProvinceId,
      required this.DistrictId,
      required this.PalikaId,
      required this.ProvinceDistrictLocallId,
      required this.EndLevelId});

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  @override
  List<Object?> get props => [
        au_user_id,
        au_first_name,
        ProvinceId,
        DistrictId,
        PalikaId,
        ProvinceDistrictLocallId,
        EndLevelId
      ];
}
