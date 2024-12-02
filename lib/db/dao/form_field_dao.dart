import 'package:clover_form/db/models/form_field_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormFieldDao {
  @Query("Select * FROM Form_Field where formId = :formId")
  Future<List<FormFieldEntity>?> getFormFields(String formId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormField(FormFieldEntity formFieldEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFormFields(List<FormFieldEntity> formFieldEntities);

  @Query("DELETE FROM Form_Field")
  Future<void> deleteAllFormFields();
}
