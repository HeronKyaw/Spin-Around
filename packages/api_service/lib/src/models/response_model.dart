/// A generic model representing the response from an API.
/// It can hold data, an error message, and a status code.
class ResponseModel<T> {
  /// The parsed data returned from the API response.
  final T? data;

  /// The error message, if any, from the API response.
  final String? error;

  /// The HTTP status code of the response.
  final int? status;

  /// Creates a [ResponseModel] with data, error, and status.
  ResponseModel({
    this.data,
    this.error,
    this.status,
  });

  /// Creates a [ResponseModel] from a JSON response.
  ///
  /// [json] represents the full JSON response from the API.
  /// [parseData] is a function that takes the raw data from the response and
  /// converts it into the desired type [T].
  factory ResponseModel.fromJson({
    required Map<String, dynamic> json,
    required T Function(dynamic) parseData,
  }) {
    return ResponseModel<T>(
      data: json['data'] != null ? parseData(json['data']) : null,
      error: json['error'],
      status: json['status'],
    );
  }
}
