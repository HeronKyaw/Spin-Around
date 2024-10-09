import 'src/dio_client.dart';
import 'src/models/request_model.dart';
import 'src/models/response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A service class that handles API requests via HTTP and Firestore operations.
///
/// This class is implemented as a singleton to ensure only one instance exists throughout the app.
///
/// Example:
/// ```dart
///  // Initialize the ApiService singleton with the base URL.
///  final apiService = ApiService(baseUrl: 'https://api.example.com');
///  ```
class ApiService {
  /// The DioClient used for making HTTP requests.
  late final DioClient dioClient;

  /// The FirebaseFirestore instance used for Firestore database operations.
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Private constructor for singleton pattern
  static final ApiService _instance = ApiService._internal();

  /// Named constructor for initializing ApiService with DioClient.
  factory ApiService({required String baseUrl}) {
    _instance.dioClient =
        DioClient(baseUrl); // Initialize DioClient with the baseUrl
    return _instance;
  }

  /// Private internal constructor.
  ApiService._internal();

  // ========== HTTP METHODS ==========

  /// Makes a POST request to the given endpoint and returns a parsed [ResponseModel].
  ///
  /// [requestModel] contains the endpoint, request body, and headers.
  /// [parseData] is a function to parse the response data into the desired type [T].
  ///
  /// Example:
  /// ```dart
  /// final response = await apiService.postRequest<User>(
  ///   RequestModel(endpoint: '/user/login', requestBody: {'username': 'test'}),
  ///   (data) => User.fromJson(data),
  /// );
  /// print('User ID: ${response.data?.id}');
  /// ```
  Future<ResponseModel<T>> postRequest<T>(
      RequestModel requestModel, T Function(dynamic) parseData) async {
    try {
      final response = await dioClient.post(
        requestModel.endpoint,
        data: requestModel.toJson(),
        headers: requestModel.requestHeaders,
      );
      return ResponseModel.fromJson(
        json: response.data,
        parseData: parseData,
      );
    } catch (error) {
      rethrow; // Handle exceptions as necessary.
    }
  }

  /// Makes a GET request to the given endpoint and returns a parsed [ResponseModel].
  ///
  /// [requestModel] contains the endpoint and headers.
  /// [parseData] is a function to parse the response data into the desired type [T].
  ///
  /// Example:
  /// ```dart
  /// final response = await apiService.getRequest<User>(
  ///   RequestModel(endpoint: '/user/1'),
  ///   (data) => User.fromJson(data),
  /// );
  /// print('User Name: ${response.data?.name}');
  /// ```
  Future<ResponseModel<T>> getRequest<T>(
      RequestModel requestModel, T Function(dynamic) parseData) async {
    try {
      final response = await dioClient.get(
        requestModel.endpoint,
        headers: requestModel.requestHeaders,
      );
      return ResponseModel.fromJson(
        json: response.data,
        parseData: parseData,
      );
    } catch (error) {
      rethrow; // Handle exceptions as necessary.
    }
  }

  // ========== FIRESTORE METHODS ==========

  /// Sets (creates or updates) a document in the Firestore collection.
  ///
  /// Example:
  /// ```dart
  /// await apiService.setDocument(
  ///   collectionPath: 'users',
  ///   documentId: 'user123',
  ///   data: {'name': 'John Doe', 'email': 'john@example.com'},
  /// );
  /// ```
  Future<void> setDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(collectionPath).doc(documentId).set(data);
    } catch (e) {
      throw Exception('Failed to set document: $e');
    }
  }

  /// Retrieves a document from the Firestore collection.
  ///
  /// Example:
  /// ```dart
  /// final userDoc = await apiService.getDocument(
  ///   collectionPath: 'users',
  ///   documentId: 'user123',
  /// );
  /// print('User Name: ${userDoc?['name']}');
  /// ```
  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection(collectionPath).doc(documentId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get document: $e');
    }
  }

  /// Retrieves all documents from a Firestore collection as a list of maps.
  ///
  /// Example:
  /// ```dart
  /// final users = await apiService.getCollection('users');
  /// print('Users: ${users.length}');
  /// ```
  Future<List<Map<String, dynamic>>> getCollection(
      String collectionPath) async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Failed to get collection: $e');
    }
  }
}
