import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../errors/exceptions.dart';
import '../../utils/app_strings.dart';
import '../storage_service.dart';
import 'api_base_service.dart';

class NetworkApiService implements BaseApiService {
  static final NetworkApiService _instance = NetworkApiService._internal();
  final LocalStorageService _localStorage = LocalStorageService();
  final Duration _defaultTimeout = const Duration(seconds: 30);

  factory NetworkApiService() {
    return _instance;
  }

  NetworkApiService._internal();

  /// build headers for the request
  Future<Map<String, String>> _getHeaders({bool requiresAuth = true}) async {
    final token = await _localStorage.getToken();
    return {
      AppStrings.contentTypeHeader: AppStrings.applicationJson,
      AppStrings.acceptHeader: AppStrings.applicationJson,
      if (token != null && requiresAuth)
        AppStrings.authorizationHeader: '${AppStrings.bearerPrefix}$token',
    };
  }

  /// --------------------------- GET Request --------------------------- ///
  @override
  Future<http.Response> getApi(String url,
      {Map<String, dynamic>? queryParams}) async {
    final Uri requestUri = _buildUri(url, queryParams);
    final headers = await _getHeaders(requiresAuth: false);
    try {
      final response =
          await http.get(requestUri, headers: headers).timeout(_defaultTimeout);

      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      debugPrint(e.toString());
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
  }

  /// --------------------------- GET Request with Auth --------------------------- ///
  @override
  Future<http.Response> getApiWithAuth(String url,
      {Map<String, dynamic>? queryParams}) async {
    final Uri requestUri = _buildUri(url, queryParams);
    final headers = await _getHeaders();

    try {
      http.Response response =
          await http.get(requestUri, headers: headers).timeout(_defaultTimeout);

      if (response.statusCode == 401) {
        // Token expired, refresh and retry
      }

      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
  }

  /// --------------------------- POST Request --------------------------- ///
  @override
  Future<http.Response> postApi(String url, dynamic data,
      {Map<String, dynamic>? queryParams}) async {
    final Uri requestUri = _buildUri(url, queryParams);
    final headers = await _getHeaders(requiresAuth: false);
    try {
      final response = await http
          .post(requestUri, body: json.encode(data), headers: headers)
          .timeout(_defaultTimeout);
      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
  }

  /// --------------------------- POST Request with Auth --------------------------- ///

  @override
  Future<http.Response> postApiWithAuth(String url, dynamic data,
      {Map<String, dynamic>? queryParams}) async {
    final Uri requestUri = _buildUri(url, queryParams);
    final headers = await _getHeaders();
    final encodedData = data is String ? data : json.encode(data);

    try {
      http.Response response = await http
          .post(requestUri, body: encodedData, headers: headers)
          .timeout(_defaultTimeout);

      if (response.statusCode == 401) {
        // Token expired, refresh and retry
      }

      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
  }

  /// --------------------------- PATCH Request --------------------------- ///
  @override
  Future<http.Response> patchApiWithAuth(String url, dynamic data,
      {Map<String, dynamic>? queryParams}) async {
    final Uri requestUri = _buildUri(url, queryParams);
    final headers = await _getHeaders();

    try {
      http.Response response = await http
          .patch(requestUri, body: json.encode(data), headers: headers)
          .timeout(_defaultTimeout);

      if (response.statusCode == 401) {
        // Token expired, refresh and retry
      }

      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
  }

  /// --------------------------- DELETE Request with Auth --------------------------- ///
  @override
  Future<http.Response> deleteApiWithAuth(String url,
      {Map<String, dynamic>? queryParams}) async {
    final Uri requestUri = _buildUri(url, queryParams);
    final headers = await _getHeaders();

    try {
      http.Response response = await http
          .delete(requestUri, headers: headers)
          .timeout(_defaultTimeout);

      if (response.statusCode == 401) {
        // Token expired, refresh and retry
      }

      return _processResponse(response);
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
  }

  /// --------------------------- POST Request with Auth and File --------------------------- ///
  @override
  Future postApiWithAuthAndFile(String url, File file) async {
    final headers = await _getHeaders();
    dynamic responseJson;

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes(
          "file", File(file.path).readAsBytesSync(),
          filename: file.path));
      var res = await request.send();
      if (res.statusCode == 200) {
        final resp = await http.Response.fromStream(res);
        return responseJson = _processResponse(resp);
      }
    } on SocketException {
      throw NoConnectionException();
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      throw AppException(AppStrings.requestFailed(e.toString()));
    }
    return responseJson;
  }

  /// Helper methods
  Uri _buildUri(String url, dynamic queryParams) {
    if (queryParams == null) {
      return Uri.parse(url);
    }
    return Uri.parse(url).replace(queryParameters: queryParams);
  }

  http.Response _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      debugPrint(
          '✅ Success: [${response.statusCode}] ${response.request?.url}');
      debugPrint(
          '✅ Response Body: ${response.body.length > 500 ? '${response.body.substring(0, 500)}...' : response.body}');
    } else {
      debugPrint('❌ Error [${response.statusCode}]: ${response.request?.url}');
      debugPrint('❌ Response Body: ${response.body}');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      default:
        return response;
    }
  }
}
