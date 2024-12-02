import 'package:clover_form/db/models/user_entity.dart';
import 'package:clover_form/network/models/user_dto.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.auUserId,
      required this.auFirstName,
      required this.provinceId,
      required this.districtId,
      required this.palikaId,
      required this.provinceDistrictLocallId,
      required this.endLevelId});

  final String auUserId;
  final String auFirstName;
  final String provinceId;
  final String districtId;
  final String palikaId;
  final String provinceDistrictLocallId;
  final String endLevelId;

  factory User.fromDTO(UserDTO userDTO) => User(
        auUserId: userDTO.au_user_id,
        auFirstName: userDTO.au_first_name,
        provinceId: userDTO.ProvinceId,
        districtId: userDTO.DistrictId,
        palikaId: userDTO.PalikaId,
        provinceDistrictLocallId: userDTO.ProvinceDistrictLocallId,
        endLevelId: userDTO.EndLevelId,
      );

  factory User.fromEntity(UserEntity userEntity) => User(
        auUserId: userEntity.auUserId,
        auFirstName: userEntity.auFirstName,
        provinceId: userEntity.provinceId,
        districtId: userEntity.districtId,
        palikaId: userEntity.palikaId,
        provinceDistrictLocallId: userEntity.provinceDistrictLocallId,
        endLevelId: userEntity.endLevelId,
      );

  @override
  List<Object?> get props => [
        auUserId,
        auFirstName,
        provinceId,
        districtId,
        palikaId,
        provinceDistrictLocallId,
        endLevelId
      ];
}
