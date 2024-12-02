// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UrlEntryDao? _urlEntryDaoInstance;

  UserDao? _userDaoInstance;

  FormDao? _formDaoInstance;

  FormFieldDao? _formFieldDaoInstance;

  FormOptionDao? _formOptionDaoInstance;

  SavedFormDao? _savedFormDaoInstance;

  SavedFormFieldDao? _savedFormFieldDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 5,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UrlEntry` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `footer` TEXT NOT NULL, `iconPath` TEXT NOT NULL, `siteUrl` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`auUserId` TEXT NOT NULL, `auFirstName` TEXT NOT NULL, `provinceId` TEXT NOT NULL, `districtId` TEXT NOT NULL, `palikaId` TEXT NOT NULL, `provinceDistrictLocallId` TEXT NOT NULL, `endLevelId` TEXT NOT NULL, PRIMARY KEY (`auUserId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Form` (`DataCollectionFormId` TEXT NOT NULL, `DataCollectionFormName` TEXT NOT NULL, `DataCollectionFormSubmissionURL` TEXT NOT NULL, `FormType` TEXT NOT NULL, PRIMARY KEY (`DataCollectionFormId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Form_Field` (`id` TEXT, `formId` TEXT, `tagName` TEXT, `type` TEXT, `name` TEXT, `fieldValue` TEXT, `label` TEXT, `dataLabel` TEXT, `classValue` TEXT, `lineNumber` INTEGER, `required` INTEGER, `alias` TEXT, `max` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Form_Field_Option` (`labelFormFieldId` TEXT NOT NULL, `label` TEXT, `formFieldId` TEXT, `tagName` TEXT, `value` TEXT, `selected` INTEGER, `lineNumber` INTEGER, PRIMARY KEY (`labelFormFieldId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Saved_Form` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `DataCollectionFormId` TEXT NOT NULL, `DataCollectionFormName` TEXT NOT NULL, `projectName` TEXT NOT NULL, `synced` INTEGER NOT NULL, `date` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Saved_Form_Field` (`fieldId` INTEGER PRIMARY KEY AUTOINCREMENT, `savedFormId` INTEGER, `id` TEXT, `formValue` TEXT, `label` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UrlEntryDao get urlEntryDao {
    return _urlEntryDaoInstance ??= _$UrlEntryDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  FormDao get formDao {
    return _formDaoInstance ??= _$FormDao(database, changeListener);
  }

  @override
  FormFieldDao get formFieldDao {
    return _formFieldDaoInstance ??= _$FormFieldDao(database, changeListener);
  }

  @override
  FormOptionDao get formOptionDao {
    return _formOptionDaoInstance ??= _$FormOptionDao(database, changeListener);
  }

  @override
  SavedFormDao get savedFormDao {
    return _savedFormDaoInstance ??= _$SavedFormDao(database, changeListener);
  }

  @override
  SavedFormFieldDao get savedFormFieldDao {
    return _savedFormFieldDaoInstance ??=
        _$SavedFormFieldDao(database, changeListener);
  }
}

class _$UrlEntryDao extends UrlEntryDao {
  _$UrlEntryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _urlEntryEntityInsertionAdapter = InsertionAdapter(
            database,
            'UrlEntry',
            (UrlEntryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'footer': item.footer,
                  'iconPath': item.iconPath,
                  'siteUrl': item.siteUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UrlEntryEntity> _urlEntryEntityInsertionAdapter;

  @override
  Future<UrlEntryEntity?> getUrlEntry() async {
    return _queryAdapter.query('Select * FROM UrlEntry',
        mapper: (Map<String, Object?> row) => UrlEntryEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            description: row['description'] as String,
            footer: row['footer'] as String,
            iconPath: row['iconPath'] as String,
            siteUrl: row['siteUrl'] as String));
  }

  @override
  Future<void> deleteAllSiteInfo() async {
    await _queryAdapter.queryNoReturn('Delete FROM UrlEntry');
  }

  @override
  Future<void> insertUrlEntry(UrlEntryEntity urlEntryEntity) async {
    await _urlEntryEntityInsertionAdapter.insert(
        urlEntryEntity, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (UserEntity item) => <String, Object?>{
                  'auUserId': item.auUserId,
                  'auFirstName': item.auFirstName,
                  'provinceId': item.provinceId,
                  'districtId': item.districtId,
                  'palikaId': item.palikaId,
                  'provinceDistrictLocallId': item.provinceDistrictLocallId,
                  'endLevelId': item.endLevelId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  @override
  Future<UserEntity?> getUser() async {
    return _queryAdapter.query('Select * FROM User',
        mapper: (Map<String, Object?> row) => UserEntity(
            auUserId: row['auUserId'] as String,
            auFirstName: row['auFirstName'] as String,
            provinceId: row['provinceId'] as String,
            districtId: row['districtId'] as String,
            palikaId: row['palikaId'] as String,
            provinceDistrictLocallId: row['provinceDistrictLocallId'] as String,
            endLevelId: row['endLevelId'] as String));
  }

  @override
  Future<void> deleteAllUser() async {
    await _queryAdapter.queryNoReturn('DELETE FROM User');
  }

  @override
  Future<void> insertUser(UserEntity userEntity) async {
    await _userEntityInsertionAdapter.insert(
        userEntity, OnConflictStrategy.abort);
  }
}

class _$FormDao extends FormDao {
  _$FormDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _formEntityInsertionAdapter = InsertionAdapter(
            database,
            'Form',
            (FormEntity item) => <String, Object?>{
                  'DataCollectionFormId': item.DataCollectionFormId,
                  'DataCollectionFormName': item.DataCollectionFormName,
                  'DataCollectionFormSubmissionURL':
                      item.DataCollectionFormSubmissionURL,
                  'FormType': item.FormType
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FormEntity> _formEntityInsertionAdapter;

  @override
  Future<List<FormEntity>?> getForms() async {
    return _queryAdapter.queryList('Select * FROM Form',
        mapper: (Map<String, Object?> row) => FormEntity(
            DataCollectionFormId: row['DataCollectionFormId'] as String,
            DataCollectionFormName: row['DataCollectionFormName'] as String,
            DataCollectionFormSubmissionURL:
                row['DataCollectionFormSubmissionURL'] as String,
            FormType: row['FormType'] as String));
  }

  @override
  Future<void> deleteAllForms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Form');
  }

  @override
  Future<void> insertForm(FormEntity formEntity) async {
    await _formEntityInsertionAdapter.insert(
        formEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertForms(List<FormEntity> formEntities) async {
    await _formEntityInsertionAdapter.insertList(
        formEntities, OnConflictStrategy.replace);
  }
}

class _$FormFieldDao extends FormFieldDao {
  _$FormFieldDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _formFieldEntityInsertionAdapter = InsertionAdapter(
            database,
            'Form_Field',
            (FormFieldEntity item) => <String, Object?>{
                  'id': item.id,
                  'formId': item.formId,
                  'tagName': item.tagName,
                  'type': item.type,
                  'name': item.name,
                  'fieldValue': item.fieldValue,
                  'label': item.label,
                  'dataLabel': item.dataLabel,
                  'classValue': item.classValue,
                  'lineNumber': item.lineNumber,
                  'required':
                      item.required == null ? null : (item.required! ? 1 : 0),
                  'alias': item.alias,
                  'max': item.max
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FormFieldEntity> _formFieldEntityInsertionAdapter;

  @override
  Future<List<FormFieldEntity>?> getFormFields(String formId) async {
    return _queryAdapter.queryList('Select * FROM Form_Field where formId = ?1',
        mapper: (Map<String, Object?> row) => FormFieldEntity(
            id: row['id'] as String?,
            formId: row['formId'] as String?,
            tagName: row['tagName'] as String?,
            type: row['type'] as String?,
            name: row['name'] as String?,
            fieldValue: row['fieldValue'] as String?,
            label: row['label'] as String?,
            dataLabel: row['dataLabel'] as String?,
            classValue: row['classValue'] as String?,
            lineNumber: row['lineNumber'] as int?,
            required:
                row['required'] == null ? null : (row['required'] as int) != 0,
            alias: row['alias'] as String?,
            max: row['max'] as String?),
        arguments: [formId]);
  }

  @override
  Future<void> deleteAllFormFields() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Form_Field');
  }

  @override
  Future<void> insertFormField(FormFieldEntity formFieldEntity) async {
    await _formFieldEntityInsertionAdapter.insert(
        formFieldEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertFormFields(List<FormFieldEntity> formFieldEntities) async {
    await _formFieldEntityInsertionAdapter.insertList(
        formFieldEntities, OnConflictStrategy.replace);
  }
}

class _$FormOptionDao extends FormOptionDao {
  _$FormOptionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _formOptionEntityInsertionAdapter = InsertionAdapter(
            database,
            'Form_Field_Option',
            (FormOptionEntity item) => <String, Object?>{
                  'labelFormFieldId': item.labelFormFieldId,
                  'label': item.label,
                  'formFieldId': item.formFieldId,
                  'tagName': item.tagName,
                  'value': item.value,
                  'selected':
                      item.selected == null ? null : (item.selected! ? 1 : 0),
                  'lineNumber': item.lineNumber
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FormOptionEntity> _formOptionEntityInsertionAdapter;

  @override
  Future<List<FormOptionEntity>?> getFormOptions(String formFieldId) async {
    return _queryAdapter.queryList(
        'Select * FROM Form_Field_Option  where formFieldId = ?1',
        mapper: (Map<String, Object?> row) => FormOptionEntity(
            labelFormFieldId: row['labelFormFieldId'] as String,
            formFieldId: row['formFieldId'] as String?,
            tagName: row['tagName'] as String?,
            value: row['value'] as String?,
            selected:
                row['selected'] == null ? null : (row['selected'] as int) != 0,
            label: row['label'] as String?,
            lineNumber: row['lineNumber'] as int?),
        arguments: [formFieldId]);
  }

  @override
  Future<void> deleteAllFormOptions() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Form_Field_Option');
  }

  @override
  Future<void> insertFormOption(FormOptionEntity formOptionEntity) async {
    await _formOptionEntityInsertionAdapter.insert(
        formOptionEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertFormOptions(
      List<FormOptionEntity> formOptionEntities) async {
    await _formOptionEntityInsertionAdapter.insertList(
        formOptionEntities, OnConflictStrategy.replace);
  }
}

class _$SavedFormDao extends SavedFormDao {
  _$SavedFormDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _savedFormEntityInsertionAdapter = InsertionAdapter(
            database,
            'Saved_Form',
            (SavedFormEntity item) => <String, Object?>{
                  'id': item.id,
                  'DataCollectionFormId': item.DataCollectionFormId,
                  'DataCollectionFormName': item.DataCollectionFormName,
                  'projectName': item.projectName,
                  'synced': item.synced ? 1 : 0,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SavedFormEntity> _savedFormEntityInsertionAdapter;

  @override
  Future<List<SavedFormEntity>?> getForms() async {
    return _queryAdapter.queryList('SELECT * FROM Saved_Form where synced = 0',
        mapper: (Map<String, Object?> row) => SavedFormEntity(
            DataCollectionFormId: row['DataCollectionFormId'] as String,
            DataCollectionFormName: row['DataCollectionFormName'] as String,
            projectName: row['projectName'] as String,
            date: row['date'] as String,
            synced: (row['synced'] as int) != 0,
            id: row['id'] as int?));
  }

  @override
  Future<List<SavedFormEntity>?> getFormsById(String formID) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Saved_Form where synced = 0 AND  DataCollectionFormId = ?1',
        mapper: (Map<String, Object?> row) => SavedFormEntity(DataCollectionFormId: row['DataCollectionFormId'] as String, DataCollectionFormName: row['DataCollectionFormName'] as String, projectName: row['projectName'] as String, date: row['date'] as String, synced: (row['synced'] as int) != 0, id: row['id'] as int?),
        arguments: [formID]);
  }

  @override
  Future<List<SavedFormEntity>?> getSyncedForms() async {
    return _queryAdapter.queryList('SELECT * FROM Saved_Form where synced = 1',
        mapper: (Map<String, Object?> row) => SavedFormEntity(
            DataCollectionFormId: row['DataCollectionFormId'] as String,
            DataCollectionFormName: row['DataCollectionFormName'] as String,
            projectName: row['projectName'] as String,
            date: row['date'] as String,
            synced: (row['synced'] as int) != 0,
            id: row['id'] as int?));
  }

  @override
  Future<List<SavedFormEntity>?> getSyncedFormsById(String formID) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Saved_Form where synced = 1 AND  DataCollectionFormId = ?1',
        mapper: (Map<String, Object?> row) => SavedFormEntity(DataCollectionFormId: row['DataCollectionFormId'] as String, DataCollectionFormName: row['DataCollectionFormName'] as String, projectName: row['projectName'] as String, date: row['date'] as String, synced: (row['synced'] as int) != 0, id: row['id'] as int?),
        arguments: [formID]);
  }

  @override
  Future<SavedFormEntity?> getForm(int id) async {
    return _queryAdapter.query('SELECT * FROM Saved_Form WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SavedFormEntity(
            DataCollectionFormId: row['DataCollectionFormId'] as String,
            DataCollectionFormName: row['DataCollectionFormName'] as String,
            projectName: row['projectName'] as String,
            date: row['date'] as String,
            synced: (row['synced'] as int) != 0,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllForms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Saved_Form');
  }

  @override
  Future<void> deleteForms(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Saved_Form WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> updateSyncedStatus(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Saved_Form SET synced = 1 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> updateProjectName(
    int id,
    String projectName,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Saved_Form SET projectName = ?2 WHERE id = ?1',
        arguments: [id, projectName]);
  }

  @override
  Future<int> insertForm(SavedFormEntity formEntity) {
    return _savedFormEntityInsertionAdapter.insertAndReturnId(
        formEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertForms(List<SavedFormEntity> formEntities) async {
    await _savedFormEntityInsertionAdapter.insertList(
        formEntities, OnConflictStrategy.replace);
  }
}

class _$SavedFormFieldDao extends SavedFormFieldDao {
  _$SavedFormFieldDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _savedFormFieldEntityInsertionAdapter = InsertionAdapter(
            database,
            'Saved_Form_Field',
            (SavedFormFieldEntity item) => <String, Object?>{
                  'fieldId': item.fieldId,
                  'savedFormId': item.savedFormId,
                  'id': item.id,
                  'formValue': item.formValue,
                  'label': item.label
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SavedFormFieldEntity>
      _savedFormFieldEntityInsertionAdapter;

  @override
  Future<List<SavedFormFieldEntity>?> getFormFields(int savedFormId) async {
    return _queryAdapter.queryList(
        'Select * FROM Saved_Form_Field where savedFormId = ?1',
        mapper: (Map<String, Object?> row) => SavedFormFieldEntity(
            fieldId: row['fieldId'] as int?,
            savedFormId: row['savedFormId'] as int?,
            id: row['id'] as String?,
            formValue: row['formValue'] as String?,
            label: row['label'] as String?),
        arguments: [savedFormId]);
  }

  @override
  Future<void> deleteAllFormFields() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Saved_Form_Field');
  }

  @override
  Future<void> deleteFormFields(int savedFormId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Saved_Form_Field where savedFormId = ?1',
        arguments: [savedFormId]);
  }

  @override
  Future<void> insertFormField(SavedFormFieldEntity formFieldEntity) async {
    await _savedFormFieldEntityInsertionAdapter.insert(
        formFieldEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertFormFields(
      List<SavedFormFieldEntity> formFieldEntities) async {
    await _savedFormFieldEntityInsertionAdapter.insertList(
        formFieldEntities, OnConflictStrategy.replace);
  }
}
