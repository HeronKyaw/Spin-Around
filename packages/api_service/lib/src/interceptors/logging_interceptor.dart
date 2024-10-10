import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A logging interceptor for Dio that prints request and response data.
class LoggingInterceptor extends Interceptor {
  /// Logs the request data before it is sent.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
        'Request [${options.method}] => PATH: ${options.path}, DATA: ${options.data}');
    super.onRequest(options, handler);
  }

  /// Logs the response data when received.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response [${response.statusCode}] => DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  /// Logs errors encountered during the request or response cycle.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'Error [${err.response?.statusCode}] => Message: ${err.message}');
    super.onError(err, handler);
  }
}
