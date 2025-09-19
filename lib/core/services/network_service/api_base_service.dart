import 'dart:io';

import 'package:http/http.dart' as http;

abstract class BaseApiService {
  Future<http.Response> getApi(String url, {Map<String, dynamic>? queryParams});

  Future<http.Response> getApiWithAuth(String url,
      {Map<String, dynamic>? queryParams});

  Future<http.Response> postApi(String url, dynamic data,
      {Map<String, dynamic>? queryParams});

  Future<http.Response> postApiWithAuth(String url, dynamic data,
      {Map<String, dynamic>? queryParams});

  Future<http.Response> patchApiWithAuth(String url, dynamic data,
      {Map<String, dynamic>? queryParams});
  
  Future<http.Response> deleteApiWithAuth(String url,
      {Map<String, dynamic>? queryParams});

  Future<dynamic> postApiWithAuthAndFile(String url, File file);
}
