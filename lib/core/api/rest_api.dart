import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:test_test/core/api/rest_api_constants.dart';

import 'exception.dart';

class RestApi {
  Future<Map<String, dynamic>> _getHeaders() async {
    final Map<String, dynamic> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };

    return headers;
  }

  Future<Dio> _getDioWithOptions(BaseOptions baseOptions) async {
    final Dio _dio = Dio(baseOptions);
    _dio.options.baseUrl = RestApiConstants.BASE_URL;
    if (_dio.options.headers.isEmpty && _dio.options.method == 'GET')
      _dio.options.headers = await _getHeaders();
    return _dio;
  }

  Future<dynamic> makeDioRequest(String path,
      {BaseOptions? baseOptions, dynamic data}) async {
    developer.log(
        "${baseOptions!.method} Request address: ${RestApiConstants.BASE_URL}$path");
    developer.log(
        "${baseOptions.method} Request query: ${baseOptions.queryParameters}");
    final Dio _dio = await _getDioWithOptions(baseOptions);

    final response = await _dio.request(RestApiConstants.BASE_URL + path,
        data: jsonEncode(data));
    developer.log("${baseOptions.method} Request code: " +
        response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.statusMessage);
      return response.data;
    } else {
      throw handleException(response);
    }
  }

  Future<ExceptionModel> handleException(Response response) async {
    developer.log(response.data.toString());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return ConnectivityException();
    } else {
      return await _handleServerError(response.data);
    }
  }

  Future<ExceptionModel> _handleServerError(String data) async {
    return UnknownException();
  }

  Future<ExceptionModel> handleApiError(Map result) async {
    final String? error = result[RestApiConstants.JSON_ERRORS];
    if (error != null) {
      String errorText = error;
      if (errorText.contains('Токен истек')) {
        return TokenExpiredException();
      }
      return ErrorException(msg: errorText);
    } else {
      return UnknownException();
    }
  }
}
