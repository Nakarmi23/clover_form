import 'package:floor/floor.dart';

import '../models/url_entry_entity.dart';

@dao
abstract class UrlEntryDao {
  @Query("Select * FROM UrlEntry")
  Future<UrlEntryEntity?> getUrlEntry();

  @insert
  Future<void> insertUrlEntry(UrlEntryEntity urlEntryEntity);

  @Query("Delete FROM UrlEntry")
  Future<void> deleteAllSiteInfo();
}
