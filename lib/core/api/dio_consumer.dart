import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:easacc_task/core/constants/app_cached.dart';
import 'package:easacc_task/core/local/shared_preferences/shared_pref_services.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../constants/api_constants.dart';
import '../di/di.dart';
import '../errors/exceptions.dart';
import 'api_consumer.dart';
import 'api_status_codes.dart';
import 'base_response.dart';
import 'dio_log_interceptor.dart';
import 'network_info.dart';

@LazySingleton(as: ApiConsumer)
class DioApiConsumer extends ApiConsumer {
  final Dio dioClient;
  final NetworkInfo networkInfo;
  final SharedPrefServices appPref;

  DioApiConsumer({
    required this.networkInfo,
    required this.dioClient,
    required this.appPref,
  }) {
    /// Fix for dio handshake error
    (dioClient.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final dioClient = HttpClient();
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };

    /// dio validation
    dioClient.options
      ..baseUrl = ApiConstants.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < ApiStatusCodes.internalServerError;
      };

    /// Debug Interceptors
    if (kDebugMode) {
      dioClient.interceptors.add(getIt<DioLogInterceptor>());
    }
  }

  Future<Map<String, dynamic>> getHeaders({String? sendToken}) async {
    String lang = appPref.getData(key: AppCached.lang) ?? "ar";
   String token = await appPref.getData(key: AppCached.token) ?? "";
    if (token.isNotEmpty) {
      return {
        'Accept': 'application/json',
        'Accept-Language': lang,
        'api-key': '11223344',
        'Authorization': 'Bearer $token',
      };
    } else {
      return {
        'Accept': 'application/json',
        'Accept-Language': lang,
        'api-key': '11223344',
        if (sendToken != null) 'Authorization': 'Bearer $sendToken'
      };
    }
  }

  @override
  Future get(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    String? token,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Response response = await dioClient.get(
          endPoint,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          options: Options(headers: await getHeaders(sendToken: token)),
        );
        return handleResponseOnly(response: response);
      } on DioException catch (error) {
        return _handelDioError(error: error);
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future post(
    String endPoint, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
    String? token,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Response response = await dioClient.post(
          endPoint,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          options: Options(headers: await getHeaders(sendToken: token)),
        );
        return handleResponseOnly(response: response);
      } on DioException catch (error) {
        return _handelDioError(error: error);
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  handleResponseOnly({required Response response}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return _handleResponseAsJson(response: response);
    } else if (response.statusCode == 422 || response.statusCode == 400) {
      return _handleResponseAsJson(response: response);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 401 || response.statusCode == 402 ||
        response.statusCode == 403) {
      final decodedData = jsonDecode(response.data);
      throw ServerErrorException(decodedData['message']);
    } else if (response.statusCode == 500) {
      throw ServerErrorException();
    }
  }

  BaseResponse _handleResponseAsJson({required Response<dynamic> response}) {
    final responseJson = jsonDecode(response.data.toString());
    return BaseResponse.fromJson(responseJson);
  }

  dynamic _handelDioError({required DioException error}) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw TimeOutException();
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException();
      case DioExceptionType.sendTimeout:
        throw TimeOutException();
      case DioExceptionType.receiveTimeout:
        throw TimeOutException();
      case DioExceptionType.badResponse:
        if (error.response!.statusCode == 404) {
          throw NotFoundException();
        } else if (error.response!.statusCode == 401 ||
            error.response!.statusCode == 402) {
          final decodedData = jsonDecode(error.response!.data);
          throw ServerErrorException(decodedData['message']);
        } else if (error.response!.statusCode == 500) {
          throw ServerErrorException();
        }
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        if (error.type.name.contains("SocketException")) {
          throw NoInternetConnectionException();
        }
        throw UnKnownException();
    }
  }
}
