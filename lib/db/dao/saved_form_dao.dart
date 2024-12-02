import 'package:floor/floor.dart';

import '../models/saved_form_entity.dart';

@dao
abstract class SavedFormDao {
  @Query("SELECT * FROM Saved_Form where synced = 0")
  Future<List<SavedFormEntity>?> getForms();

  @Query("SELECT * FROM Saved_Form where synced = 0 AND  DataCollectionFormId = :formID")
  Future<List<SavedFormEntity>?> getFormsById(String formID);

  @Query("SELECT * FROM Saved_Form where synced = 1")
  Future<List<SavedFormEntity>?> getSyncedForms();

  @Query("SELECT * FROM Saved_Form where synced = 1 AND  DataCollectionFormId = :formID")
  Future<List<SavedFormEntity>?> getSyncedFormsById(String formID);

  @Query("SELECT * FROM Saved_Form WHERE id = :id")
  Future<SavedFormEntity?> getForm(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertForm(SavedFormEntity formEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertForms(List<SavedFormEntity> formEntities);

  @Query("DELETE FROM Saved_Form")
  Future<void> deleteAllForms();

  @Query("DELETE FROM Saved_Form WHERE id = :id")
  Future<void> deleteForms(int id);

  @Query('UPDATE Saved_Form SET synced = 1 WHERE id = :id')
  Future<void> updateSyncedStatus(int id);

  @Query('UPDATE Saved_Form SET projectName = :projectName WHERE id = :id')
  Future<void> updateProjectName(int id, String projectName);
}
