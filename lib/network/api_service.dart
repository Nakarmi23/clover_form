import 'package:clover_form/network/models/form_dto.dart';
import 'package:clover_form/network/models/url_entry_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

const String baseurl = 'https://draft.srssolutions.com.np/migrantworker';
const String version = '/api';

@RestApi(baseUrl: baseurl + version)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/siteVerification')
  Future<UrlEntryDTO?> siteVerification();

  @POST('/ProjectDetail')
  Future<List<FormDTO?>> getForms();
}
