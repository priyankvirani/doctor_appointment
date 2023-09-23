import 'package:dio/dio.dart';
import 'package:flutter_doctor_appointment/helper/app_constants.dart';

class ApiHelper {
  static Dio createDio(
      {bool isCustomUrl = false, Map<String, String>? header}) {
    Dio dio = Dio(BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        responseType: ResponseType.json,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: header));
    return dio;
  }
}
