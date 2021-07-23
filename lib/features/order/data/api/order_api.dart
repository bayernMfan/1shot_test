import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_test/core/api/exception.dart';

import 'package:test_test/core/api/rest_api.dart';
import 'package:test_test/core/api/rest_api_constants.dart';

class OrderApi extends RestApi {
  @override
  Future<dynamic> makeDioRequest(String path,
      {BaseOptions? baseOptions, dynamic data}) async {
    try {
      final result = await super
          .makeDioRequest(path, baseOptions: baseOptions, data: data);

      if (result == null) {
        throw NoDataException();
      }
      if (result.containsKey(RestApiConstants.JSON_ERRORS)) {
        throw await super.handleApiError(result);
      } else if (result.containsKey(RestApiConstants.JSON_DATA)) {
        return result[RestApiConstants.JSON_DATA];
      } else {
        return result;
      }
    } catch (e) {
      if (e is DioError) {
        dynamic finalResult = e.response!.data;
        if (finalResult == null) {
          throw ErrorException(msg: e.error.toString());
        }
        if (finalResult.containsKey(RestApiConstants.JSON_ERRORS)) {
          throw await super.handleApiError(finalResult);
        } else if (finalResult.containsKey(RestApiConstants.JSON_DATA)) {
          return finalResult[RestApiConstants.JSON_DATA];
        } else {
          return finalResult;
        }
      }
    }
  }

  Future<dynamic> getMerchImage(String? imageId) async {
    BaseOptions _options = BaseOptions(method: 'GET', headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: 'Client-ID ' + RestApiConstants.AUTH_KEY,
    });
    final response = await makeDioRequest(RestApiConstants.PHOTOS + imageId!,
        baseOptions: _options, data: {});

    return response;
  }

}
