/// A model representing an API request.
/// Contains the endpoint, request body, and headers.
class RequestModel {
  /// The API endpoint for the request.
  final String endpoint;

  /// The request body to be sent in the API call.
  /// Defaults to an empty map.
  final Map<String, dynamic> requestBody;

  /// The headers to be sent in the API call.
  /// Defaults to an empty map.
  final Map<String, String> requestHeaders;

  /// Creates a [RequestModel] with an endpoint, request body, and headers.
  RequestModel({
    required this.endpoint,
    this.requestBody = const {},
    this.requestHeaders = const {},
  });

  /// Converts the [requestBody] to a JSON-compatible map.
  Map<String, dynamic> toJson() => requestBody;
}
