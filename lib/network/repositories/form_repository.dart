import 'dart:async';
import 'dart:convert';

import 'package:clover_form/db/models/form_entity.dart';
import 'package:clover_form/db/models/form_field_entity.dart';
import 'package:clover_form/db/models/form_option_entity.dart';
import 'package:clover_form/feature/home/models/form_model.dart';
import 'package:clover_form/feature/home/models/form_model_field.dart';
import 'package:clover_form/feature/home/models/form_option.dart';
import 'package:clover_form/network/models/form_dto.dart';
import 'package:dio/dio.dart';

import '../../db/app_database.dart';
import '../../db/models/saved_form_entity.dart';
import '../../db/models/saved_form_field_entity.dart';
import '../../feature/saved_form/models/SavedFormModel.dart';
import '../dio_helper.dart';
import '../models/form_field_dto.dart';

class FormRepository {
  Future<List<FormModel>> getForms(String formId, String userId) async {
    try {
      List<FormDTO> datas =
          await DioHelper.getInstance().getForms(formId, userId);

      List<FormModel> list = [];
      for (var formDTO in datas) {
        formField() {
          var encodedString =
              formDTO.DataCollectionFormFields.replaceAll('\\', '');

          List<dynamic> jsonList =
              encodedString == "0" ? [] : json.decode(encodedString);
          List<FormModelField> formFieldDTO = encodedString == "0"
              ? []
              : jsonList.map((json) {
                  var formFieldDto =
                      FormFieldDTO.fromJson(json as Map<String, dynamic>);
                  return FormModelField.fromDTO(formFieldDto);
                }).toList();

          return FormModel.fromDTO(formDTO, formFieldDTO);
        }

        list.add(formField());
      }
      return list;
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

  Future<List<FormModel>> getFormsDb() async {
    final database = await getDatabase();
    final formDao = database.formDao;
    var list = await formDao
        .getForms()
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    if (list == null) {
      throw Exception("No data available");
    } else {
      return list.map((entity) => FormModel.fromEntity(entity)).toList();
    }
  }

  Future<List<FormModelField>> getFormModelFieldsDb(String formID) async {
    final database = await getDatabase();
    final formFieldDao = database.formFieldDao;
    var list = await formFieldDao
        .getFormFields(formID)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    if (list == null) {
      throw Exception("No data available");
    } else {
      List<FormModelField> data = [];
      for (var entity in list) {
        if (entity.id?.split(',').last != null) {
          var optionEntities =
              await getFormOptionsDb(entity.id!.split(',').last);
          data.add(FormModelField.fromEntity(entity, optionEntities));
        } else {
          data.add(FormModelField.fromEntity(entity, null));
        }
      }
      return data;
    }
  }

  Future<List<FormOption>> getFormOptionsDb(String formFieldID) async {
    final database = await getDatabase();
    final formOptionDao = database.formOptionDao;
    var list = await formOptionDao
        .getFormOptions(formFieldID)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();

    if (list == null) {
      return [];
    } else {
      return list.map((entity) {
        return FormOption.fromEntity(entity);
      }).toList();
    }
  }

  Future<List<SavedFormModel>> getSavedFormsDb(String formID) async {
    final database = await getDatabase();
    final formDao = database.savedFormDao;
    var list = await formDao
        .getFormsById(formID)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    if (list == null) {
      throw Exception("No data available");
    } else {
      return list.map((entity) => SavedFormModel.fromEntity(entity)).toList();
    }
  }

  Future<List<SavedFormModel>> getSavedSyncedFormsDb(String formID) async {
    final database = await getDatabase();
    final formDao = database.savedFormDao;
    var list = await formDao
        .getSyncedFormsById(formID)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    if (list == null) {
      throw Exception("No data available");
    } else {
      return list.map((entity) => SavedFormModel.fromEntity(entity)).toList();
    }
  }

  Future<bool> saveForms(List<FormEntity> entities) async {
    final database = await getDatabase();
    final formDao = database.formDao;
    await formDao
        .insertForms(entities)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    return true;
  }

  Future<bool> saveFormFields(List<FormFieldEntity> entities) async {
    final database = await getDatabase();
    final formFieldDao = database.formFieldDao;
    await formFieldDao
        .insertFormFields(entities)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    return true;
  }

  Future<bool> saveFormOptions(List<FormOptionEntity> entities) async {
    final database = await getDatabase();
    final formOptionDao = database.formOptionDao;
    await formOptionDao
        .insertFormOptions(entities)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    return true;
  }

  Future<int> saveFormData(SavedFormEntity entity) async {
    final database = await getDatabase();
    final formDao = database.savedFormDao;

    try {
      final savedFormID = await formDao.insertForm(entity);
      database.close();
      return savedFormID;
    } catch (e) {
      database.close();
      throw Exception("Error with database");
    }
  }

  Future<bool> saveFormFieldData(List<SavedFormFieldEntity> entities) async {
    final database = await getDatabase();
    final formFieldDao = database.savedFormFieldDao;

    await formFieldDao
        .insertFormFields(entities)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    database.close();
    return true;
  }

  Future<List<SavedFormFieldEntity>> getSavedFormFieldData(int fieldId) async {
    final database = await getDatabase();
    final formDao = database.savedFormFieldDao;
    var list = await formDao
        .getFormFields(fieldId)
        .onError((error, stackTrace) => throw Exception("Error with database"));

    database.close();
    if (list == null) {
      throw Exception("No data available");
    } else {
      return list;
    }
  }

  Future<void> syncFormToApi(int id, String auUserId, String dataCollectionTime,
      List<SavedFormFieldEntity> entities) async {
    try {
      await DioHelper.getInstance()
          .syncFormField(id, auUserId, dataCollectionTime, entities);
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

  Future<void> deleteFormAndFields(int formId) async {
    final database = await getDatabase();
    final formDao = database.savedFormDao;
    final formFieldDao = database.savedFormFieldDao;

    try {
      await formDao.deleteForms(formId);
      await formFieldDao.deleteFormFields(formId);
    } catch (e) {
      throw Exception("Error deleting form and form fields from database");
    } finally {
      database.close();
    }
  }

  Future<void> updateFormStatusSynced(int formId) async {
    final database = await getDatabase();
    final formDao = database.savedFormDao;

    try {
      await formDao.updateSyncedStatus(formId);
    } catch (e) {
      throw Exception("Error updating form and form fields from database");
    } finally {
      database.close();
    }
  }

  Future<void> updateFormTitle(int formId, String title) async {
    final database = await getDatabase();
    final formDao = database.savedFormDao;

    try {
      await formDao.updateProjectName(formId, title);
    } catch (e) {
      throw Exception("Error updating form and form fields from database");
    } finally {
      database.close();
    }
  }
}
