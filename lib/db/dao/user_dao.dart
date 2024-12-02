import 'package:clover_form/db/models/user_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @Query("Select * FROM User")
  Future<UserEntity?> getUser();

  @insert
  Future<void> insertUser(UserEntity userEntity);

  @Query("DELETE FROM User")
  Future<void> deleteAllUser();
}
