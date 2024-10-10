import 'package:api_service/src/models/response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponseModel', () {
    test('should parse valid JSON response', () {
      final jsonResponse = {
        'data': {'id': 1, 'name': 'Test'},
        'error': null,
        'status': 200,
      };

      final response = ResponseModel.fromJson(
        json: jsonResponse,
        parseData: (data) => data, // Directly return data as it is
      );

      expect(response.data, equals({'id': 1, 'name': 'Test'}));
      expect(response.error, isNull);
      expect(response.status, equals(200));
    });

    test('should handle null data in response', () {
      final jsonResponse = {
        'data': null,
        'error': 'Something went wrong',
        'status': 500,
      };

      final response = ResponseModel.fromJson(
        json: jsonResponse,
        parseData: (data) => data,
      );

      expect(response.data, isNull);
      expect(response.error, equals('Something went wrong'));
      expect(response.status, equals(500));
    });
  });
}
