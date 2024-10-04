import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
class DioClient {
  final Dio dio;

  DioClient(this.dio);

  CancelToken _cancelToken = CancelToken();

  Future<Response?> post({
    required String path,
    dynamic request,
    required Function(dynamic, String?) responseCallback,
    required Function(String?, int?) failureCallback,
    dynamic header,
  }) async {
    Response? response;
    try {
      _cancelToken.cancel("Cancelled due to new request");
      _cancelToken = CancelToken();

        response = await dio.post(
          // cancelToken: _cancelToken,
          path,
          data: request,
          options: Options(
            method: "POST",
            receiveTimeout: const Duration(milliseconds: 30000),
          ),
        );

        if (response.data != null) {
          responseCallback(response.data, response.statusMessage);
        } else {
          failureCallback(response.statusMessage, response.statusCode);
        }
    } catch (e) {
      failureCallback("Something went wrong!", 400);
    }
    return response;
  }

  Future<Response?> get({
    required String path,
    dynamic request,
    required Function(dynamic, String?) responseCallback,
    required Function(String?, int?) failureCallback,
    Map<String, dynamic>? queryParameters,
    bool includeHeader = false,
    String contentType = Headers.formUrlEncodedContentType,
  }) async {
    Response? response;

    try {

        response = await dio.get(
          path,
          data: request,
          queryParameters: queryParameters,
          options: Options(
            contentType: contentType,
            receiveTimeout: const Duration(milliseconds: 30000),
          ),
        );

        if (response.data != null && response.statusCode == HttpStatus.ok) {
          responseCallback(response.data, response.statusMessage);
        } else {
          failureCallback(response.statusMessage, response.statusCode);
        }
    } on Exception catch (e, _) {
      failureCallback(e.toString(), 400);
    }
    return response;
  }
}

