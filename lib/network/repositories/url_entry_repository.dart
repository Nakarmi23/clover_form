import 'dart:async';

import 'package:clover_form/db/models/url_entry_entity.dart';
import 'package:clover_form/network/models/url_entry_dto.dart';
import 'package:dio/dio.dart';

import '../../db/app_database.dart';
import '../../feature/url_entry/models/url_entry.dart';
import '../dio_helper.dart';

class UrlEntryRepository {
  Future<UrlEntry> getSiteInfo(String url) async {
    try {
      UrlEntryDTO urlEntryDTO = await DioHelper.getInstance().verifySite(url);
      return UrlEntry.fromDTO(urlEntryDTO);
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

  Future<bool> saveSiteInfo(UrlEntryEntity entity) async {
    final database =await getDatabase();
    final urlEntryDao = database.urlEntryDao;
    await urlEntryDao
        .insertUrlEntry(entity)
        .onError((error, stackTrace) => throw Exception("Error with database"));
    return true;
  }

  Future<UrlEntryEntity?> getSiteInfoDb() async {
    final database =await getDatabase();
    final urlEntryDao = database.urlEntryDao;
    final data = await urlEntryDao.getUrlEntry();
    return data;
  }

  Future<void> deleteSiteInfoDb() async {
    final database =await getDatabase();
    final urlEntryDao = database.urlEntryDao;
    await urlEntryDao.deleteAllSiteInfo();
  }
}
