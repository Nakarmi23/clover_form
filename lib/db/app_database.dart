import 'dart:async';

import 'package:clover_form/db/dao/form_dao.dart';
import 'package:clover_form/db/dao/form_field_dao.dart';
import 'package:clover_form/db/dao/form_option_dao.dart';
import 'package:clover_form/db/dao/url_entry_dao.dart';
import 'package:clover_form/db/dao/user_dao.dart';
import 'package:clover_form/db/models/form_entity.dart';
import 'package:clover_form/db/models/form_field_entity.dart';
import 'package:clover_form/db/models/form_option_entity.dart';
import 'package:clover_form/db/models/user_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/saved_form_dao.dart';
import 'dao/saved_form_field_dao.dart';
import 'models/saved_form_entity.dart';
import 'models/saved_form_field_entity.dart';
import 'models/url_entry_entity.dart';

part 'app_database.g.dart';

@Database(version: 5, entities: [
  UrlEntryEntity,
  UserEntity,
  FormEntity,
  FormFieldEntity,
  FormOptionEntity,
  SavedFormEntity,
  SavedFormFieldEntity,
])
abstract class AppDatabase extends FloorDatabase {
  UrlEntryDao get urlEntryDao;

  UserDao get userDao;

  FormDao get formDao;

  FormFieldDao get formFieldDao;

  FormOptionDao get formOptionDao;

  SavedFormDao get savedFormDao;

  SavedFormFieldDao get savedFormFieldDao;

  static final Migration migration1to2 =
      Migration(1, 2, (sqflite.Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS Saved_Form (id INTEGER PRIMARY KEY AUTOINCREMENT, DataCollectionFormId TEXT, DataCollectionFormName TEXT, date TEXT, FormType TEXT, ProjectListFetchURL TEXT)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS Saved_Form_Field (fieldId INTEGER PRIMARY KEY AUTOINCREMENT, savedFormId INTEGER, id TEXT, formValue TEXT)');
  });

  static final Migration migration2to3 =
      Migration(2, 3, (sqflite.Database database) async {
    await database.execute(
        'ALTER TABLE Saved_Form ADD COLUMN projectName TEXT NOT NULL DEFAULT ""');
  });

  static final Migration migration3to4 = Migration(3, 4, (database) async {
    await database.execute(
        'ALTER TABLE Saved_Form ADD COLUMN synced INTEGER NOT NULL DEFAULT 0');
  });

  static final Migration migration4to5 = Migration(4, 5, (database) async {
    await database.execute(
        'ALTER TABLE Saved_Form_Field ADD COLUMN label TEXT NOT NULL DEFAULT ""');
  });
}

Future<AppDatabase> getDatabase() async {
  return await $FloorAppDatabase.databaseBuilder('clover.db').addMigrations([
    AppDatabase.migration1to2,
    AppDatabase.migration2to3,
    AppDatabase.migration3to4,
    AppDatabase.migration4to5,
  ]).build();
}
