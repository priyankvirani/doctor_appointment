import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/app_constants.dart';

import '../helper/navigation.dart';


const _defaultConnectTimeout = Duration.millisecondsPerMinute * 5;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute * 5;

extension DioErrorX on DioError {
  bool get isNoConnectionError =>
      type == DioErrorType.other &&
      error is SocketException; // import 'dart:io' for SocketException
}

class RestApiService {
  late Dio? _dio;

  factory RestApiService() => instance;

  RestApiService._() {
    initializeClient();
  }

  static final RestApiService instance = RestApiService._();

  Future<bool> initializeClient() async {
    _dio = Dio();
    _dio?.options.baseUrl = AppConstants.apiBaseUrl;
    _dio?.options.connectTimeout = _defaultConnectTimeout;
    _dio?.options.receiveTimeout = _defaultReceiveTimeout;
    _dio?.httpClientAdapter;
    if (kDebugMode) {
      _dio?.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: false,
          requestBody: true));
    }
    _dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //modify your request
    }, onError: (DioError e, handler) async {
      print(e);
    }));
    return true;
  }

  Future<dynamic> get(
    String endPoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio?.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response?.data;
    } on DioError catch (e) {
      if (e.response?.data != null) {
        return e.response!.data;
      } else {
        return e.response!.data;
      }
    } catch (e) {
      return e.toString();
    }
  }



}
