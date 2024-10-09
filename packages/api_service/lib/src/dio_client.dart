import 'package:dio/dio.dart';
import 'interceptors/logging_interceptor.dart';

/// A singleton class for Dio HTTP client with base configuration and interceptors.
class DioClient {
  /// The Dio instance used for making HTTP requests.
  final Dio _dio;

  /// The base URL for API requests.
  late String baseUrl;

  // Private constructor for singleton pattern.
  static final DioClient _instance = DioClient._internal();

  /// Factory constructor to ensure singleton instance.
  factory DioClient(String baseUrl) {
    _instance.baseUrl = baseUrl;
    return _instance;
  }

  /// Private internal constructor with Dio configuration.
  DioClient._internal()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(LoggingInterceptor());
  }

  /// Makes a GET request to the given [endpoint] with optional [headers].
  ///
  /// Example:
  /// ```dart
  /// final response = await dioClient.get('/user/1');
  /// print(response.data);
  /// ```
  Future<Response> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      return await _dio.get(endpoint, options: Options(headers: headers));
    } on DioException catch (e) {
      // Handle different Dio exceptions
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout occurred.");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive timeout occurred.");
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception("Received invalid response: ${e.response?.statusCode}");
      } else {
        throw Exception("Unknown Dio error occurred.");
      }
    } catch (error) {
      throw Exception("An unknown error occurred.");
    }
  }

  /// Makes a POST request to the given [endpoint] with optional [data] and [headers].
  ///
  /// Example:
  /// ```dart
  /// final response = await dioClient.post('/user/create', data: {'name': 'John'});
  /// print(response.data);
  /// ```
  Future<Response> post(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      return await _dio.post(endpoint,
          data: data, options: Options(headers: headers));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout occurred.");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive timeout occurred.");
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception("Received invalid response: ${e.response?.statusCode}");
      } else {
        throw Exception("Unknown Dio error occurred.");
      }
    } catch (error) {
      throw Exception("An unknown error occurred.");
    }
  }
}
