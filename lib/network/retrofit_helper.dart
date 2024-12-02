import 'package:dio/dio.dart';

import 'api_service.dart';

class RetrofitHelper {
  late ApiService apiService;

  RetrofitHelper() {
    final dio = Dio();
    apiService = ApiService(dio);
  }

  ApiService getApiService() {
    return apiService;
  }
}
