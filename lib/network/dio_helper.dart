import 'package:clover_form/network/models/user_dto.dart';
import 'package:dio/dio.dart';

import '../db/models/saved_form_field_entity.dart';
import 'models/form_dto.dart';
import 'models/url_entry_dto.dart';

class DioHelper {
  late Dio dio;
  static late DioHelper _dioHelper;
  static String baseUrl = "https://draft.srssolutions.com.np/migrantworker/api";

  DioHelper() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
  }

  static DioHelper getInstance() {
    try {
      return _dioHelper;
    } catch (_) {
      _dioHelper = DioHelper();
      return _dioHelper;
    }
  }

  Future<UrlEntryDTO> verifySite(String url) async {
    var headers = {
      'Cookie': 'session=003ea8f6f20544f5614873b0e1bf5989f2ebf3d5'
    };
    var data = FormData.fromMap({'SiteURL': url});

    var response = await dio.request(
      '/siteVerification',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return UrlEntryDTO.fromJson(response.data);
    } else {
      throw Exception("There was an error in api. Please try again later");
    }
  }

  Future<UserDTO> login(String userName, String password) async {
    var headers = {
      'Cookie': 'session=bedf87c938a4b2295fe7af7605744f3d8ae57c63'
    };
    var data = FormData.fromMap({
      'UserName': userName,
      'Password': password,
    });

    var response = await dio.request(
      '/userAuthentication',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return UserDTO.fromJson(response.data);
    } else {
      throw Exception("There was an error in api. Please try again later");
    }
  }

  Future<List<FormDTO>> getForms(String formId, String userId) async {
    var headers = {
      'Cookie':
          'SRSSolutionsProjectCOOKIE=5d2928247004e4df9b5051a6c0a7c0f3; session=213fb2c81a907baa36dee8b73e02a182651e32c3'
    };
    var data =
        FormData.fromMap({'DataCollectionFormId': formId, 'UserId': userId});

    var response = await dio.request(
      '/ProjectDetail',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((form) => FormDTO.fromJson(form))
          .toList();
    } else {
      throw Exception("There was an error in api. Please try again later");
    }
  }

  Future<void> syncFormField(int formId, String userId,
      String dataCollectionTime, List<SavedFormFieldEntity> list) async {
    var headers = {
      'Cookie': 'session=004f690f533390c10e718a302eef17a9af48fa6d'
    };
    var data = FormData.fromMap({
      'LocalTransactionId': formId,
      'UserId': userId,
      'DataCollectionDateTime': dataCollectionTime,
    });

    for (var formFieldEntity in list) {
      if (formFieldEntity.label == 'Select Administrative location') {
        data.fields.add(
          MapEntry(
            formFieldEntity.id.toString(),
            '',
          ),
        );
        if (formFieldEntity.formValue?.isNotEmpty == true) {
          var administrativeLocationValue = formFieldEntity.formValue ?? '';
          var locationParts = administrativeLocationValue.split('-AdminData-');

          var province =
              (locationParts.isNotEmpty && locationParts[0].isNotEmpty)
                  ? locationParts[0]
                  : '';
          var distrct =
              (locationParts.length > 1 && locationParts[1].isNotEmpty)
                  ? locationParts[1]
                  : '';
          var palika = (locationParts.length > 2 && locationParts[2].isNotEmpty)
              ? locationParts[2]
              : '';

          data.fields.add(
            MapEntry(
              "ProvinceId",
              province,
            ),
          );
          data.fields.add(
            MapEntry(
              "DistrictId",
              distrct,
            ),
          );
          data.fields.add(
            MapEntry(
              "PalikaId",
              palika,
            ),
          );
        }

      } else {
        data.fields.add(
          MapEntry(
            formFieldEntity.id.toString(),
            formFieldEntity.formValue ?? '',
          ),
        );
      }
    }

    var response = await dio.request(
      '/PostProjectData',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode != 200) {
      throw Exception("There was an error in api. Please try again later");
    } else {
      print(response.data);
    }
  }
}
