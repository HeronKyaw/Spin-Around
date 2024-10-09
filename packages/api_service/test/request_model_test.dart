import 'package:api_service/src/models/request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RequestModel', () {
    test('should convert requestBody to JSON', () {
      final requestModel = RequestModel(
        endpoint: '/test',
        requestBody: {'key': 'value'},
      );

      expect(requestModel.toJson(), equals({'key': 'value'}));
    });

    test('should have default empty headers and body', () {
      final requestModel = RequestModel(endpoint: '/test');
      expect(requestModel.requestBody, isEmpty);
      expect(requestModel.requestHeaders, isEmpty);
    });
  });
}
