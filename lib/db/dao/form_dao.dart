import 'package:clover_form/db/models/form_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormDao {
  @Query("Select * FROM Form")
  Future<List<FormEntity>?> getForms();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertForm(FormEntity formEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertForms(List<FormEntity> formEntities);

  @Query("DELETE FROM Form")
  Future<void> deleteAllForms();
}
