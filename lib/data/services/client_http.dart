import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:result_dart/result_dart.dart';

/// A HTTP client wrapper around Dio with built-in caching support.
///
/// This client provides methods for making HTTP requests and handles:
/// * Request caching using DioCacheInterceptor
/// * Error handling with Result type
/// * Common HTTP methods (GET, POST, PUT, DELETE, PATCH)
///
/// Example:
/// ```dart
/// final client = ClientHttp();
/// final result = await client.get('https://api.example.com/data');
/// ```
class ClientHttp {
  /// Creates a new HTTP client with optional Dio instance.
  ///
  /// If no [dio] is provided, creates a new instance with cache interceptor.
  /// The cache is stored in memory using [MemCacheStore].
  ClientHttp({Dio? dio})
      : _dio = dio ?? Dio()
          ..interceptors.add(
            DioCacheInterceptor(
              options: CacheOptions(store: MemCacheStore()),
            ),
          );

  late final Dio _dio;

  /// Performs a GET request to the specified path.
  ///
  /// Parameters:
  /// * [path] - The URL path to request
  /// * [queryParameters] - Optional URL query parameters
  /// * [data] - Optional request body data
  /// * [options] - Optional Dio request options
  ///
  /// Returns a [Result] containing either the response or an error.
  AsyncResult<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        data: data,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  /// Performs a POST request to the specified path.
  ///
  /// Parameters:
  /// * [path] - The URL path to request
  /// * [queryParameters] - Optional URL query parameters
  /// * [data] - Request body data
  /// * [options] - Optional Dio request options
  ///
  /// Returns a [Result] containing either the response or an error.
  AsyncResult<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  /// Performs a PUT request to the specified path.
  ///
  /// Parameters:
  /// * [path] - The URL path to request
  /// * [queryParameters] - Optional URL query parameters
  /// * [data] - Request body data
  /// * [options] - Optional Dio request options
  ///
  /// Returns a [Result] containing either the response or an error.
  AsyncResult<Response<T>> put<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  /// Performs a DELETE request to the specified path.
  ///
  /// Parameters:
  /// * [path] - The URL path to request
  /// * [queryParameters] - Optional URL query parameters
  /// * [data] - Optional request body data
  /// * [options] - Optional Dio request options
  ///
  /// Returns a [Result] containing either the response or an error.
  AsyncResult<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  /// Performs a PATCH request to the specified path.
  ///
  /// Parameters:
  /// * [path] - The URL path to request
  /// * [queryParameters] - Optional URL query parameters
  /// * [data] - Request body data
  /// * [options] - Optional Dio request options
  ///
  /// Returns a [Result] containing either the response or an error.
  AsyncResult<Response<T>> patch<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
