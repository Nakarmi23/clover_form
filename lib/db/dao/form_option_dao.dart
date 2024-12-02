import 'package:clover_form/db/models/form_option_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormOptionDao {
  @Query("Select * FROM Form_Field_Option  where formFieldId = :formFieldId")
  Future<List<FormOptionEntity>?> getFormOptions(String formFieldId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormOption(FormOptionEntity formOptionEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormOptions(List<FormOptionEntity> formOptionEntities);

  @Query("DELETE FROM Form_Field_Option")
  Future<void> deleteAllFormOptions();
}
