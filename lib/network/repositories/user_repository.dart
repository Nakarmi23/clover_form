import 'dart:async';

import 'package:clover_form/db/models/user_entity.dart';
import 'package:clover_form/feature/login/models/user.dart';
import 'package:clover_form/network/models/user_dto.dart';
import 'package:dio/dio.dart';

import '../../db/app_database.dart';
import '../dio_helper.dart';

class UserRepository {
  Future<User> login(String userName, String password) async {
    try {
      UserDTO userDTO = await DioHelper.getInstance().login(userName, password);
      return User.fromDTO(userDTO);
    } on DioException catch (e) {
      if (e.response != null) {
        String? msg = e.response?.data?.toString();
        throw Exception(msg);
      } else {
        throw Exception(e.message);
      }
    } catch (ex) {
      throw Exception(ex);
    }
  }

  Future<bool> saveUser(UserEntity entity) async {
    final database = await getDatabase();
    final userDao = database.userDao;
    await userDao
        .insertUser(entity)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    return true;
  }

  Future<User?> getUserDb() async {
    final database = await getDatabase();
    final userDao = database.userDao;
    var userEntity = await userDao
        .getUser()
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    if (userEntity == null) {
      return null;
    } else {
      return User.fromEntity(userEntity);
    }
  }

  Future<void> deleteUserDb() async {
    final database = await getDatabase();
    final userDao = database.userDao;
    await userDao.deleteAllUser();
  }
}
