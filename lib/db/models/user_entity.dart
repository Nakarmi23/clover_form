import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../feature/login/models/user.dart';

@Entity(tableName: "User")
class UserEntity extends Equatable {
  @primaryKey
  final String auUserId;
  final String auFirstName;
  final String provinceId;
  final String districtId;
  final String palikaId;
  final String provinceDistrictLocallId;
  final String endLevelId;

  const UserEntity(
      {required this.auUserId,
      required this.auFirstName,
      required this.provinceId,
      required this.districtId,
      required this.palikaId,
      required this.provinceDistrictLocallId,
      required this.endLevelId});

  factory UserEntity.fromModel(User user) => UserEntity(
      auUserId: user.auUserId,
      auFirstName: user.auFirstName,
      provinceId: user.provinceId,
      districtId: user.districtId,
      palikaId: user.palikaId,
      provinceDistrictLocallId: user.provinceDistrictLocallId,
      endLevelId: user.endLevelId);

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
