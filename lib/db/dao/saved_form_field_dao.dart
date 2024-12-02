import 'package:floor/floor.dart';

import '../models/saved_form_field_entity.dart';

@dao
abstract class SavedFormFieldDao {
  @Query("Select * FROM Saved_Form_Field where savedFormId = :savedFormId")
  Future<List<SavedFormFieldEntity>?> getFormFields(int savedFormId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormField(SavedFormFieldEntity formFieldEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormFields(List<SavedFormFieldEntity> formFieldEntities);

  @Query("DELETE FROM Saved_Form_Field")
  Future<void> deleteAllFormFields();

  @Query("DELETE FROM Saved_Form_Field where savedFormId = :savedFormId")
  Future<void> deleteFormFields(int savedFormId);
}
