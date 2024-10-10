import 'package:api_service/src/interceptors/logging_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

class MockRequestOptions extends Mock implements RequestOptions {}

class MockResponse extends Mock implements Response {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockDioException extends Mock implements DioException {}

void main() {
  group('LoggingInterceptor', () {
    final interceptor = LoggingInterceptor();

    test('logs request data', () {
      final options = MockRequestOptions();
      final handler = MockRequestInterceptorHandler();

      when(options.method).thenReturn('GET');
      when(options.path).thenReturn('/test');
      when(options.data).thenReturn({'key': 'value'});

      interceptor.onRequest(options, handler);

      verify(options.method);
      verify(options.path);
      verify(options.data);
    });

    test('logs response data', () {
      final response = MockResponse();
      final handler = MockResponseInterceptorHandler();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn({'key': 'value'});

      interceptor.onResponse(response, handler);

      verify(response.statusCode);
      verify(response.data);
    });

    test('logs error data', () {
      final error = MockDioException();
      final handler = MockErrorInterceptorHandler();

      when(error.message).thenReturn('Test error');
      when(error.response?.statusCode).thenReturn(400);

      interceptor.onError(error, handler);

      verify(error.message);
      verify(error.response?.statusCode);
    });
  });
}
