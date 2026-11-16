import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'api_exception.dart';

/// Thin wrapper around package:http that returns decoded JSON and
/// converts every failure into a user-friendly [ApiException].
class ApiClient {
  ApiClient({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? ApiConfig.baseUrl;

  final http.Client _client;
  final String _baseUrl;

  static const _timeout = Duration(seconds: 15);
  static const _unreachable =
      'Cannot reach the server. Check that the API is running and the URL is correct.';

  Future<Map<String, dynamic>> get(String path, {Map<String, String>? query}) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: query);
    try {
      final response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(_timeout);
      return _decode(response);
    } on TimeoutException {
      throw ApiException('The server took too long to respond. Please try again.');
    } on SocketException {
      throw ApiException(_unreachable);
    } on http.ClientException {
      throw ApiException(_unreachable);
    }
  }

  Map<String, dynamic> _decode(http.Response response) {
    Map<String, dynamic>? body;
    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is Map<String, dynamic>) body = decoded;
    } on FormatException {
      body = null;
    }

    final ok = response.statusCode >= 200 && response.statusCode < 300;
    if (ok && body != null) return body;

    String? message;
    final error = body?['error'];
    if (error is Map && error['message'] is String) {
      message = error['message'] as String;
    }
    throw ApiException(
      message ?? 'Request failed (${response.statusCode}).',
      statusCode: response.statusCode,
    );
  }

  void dispose() => _client.close();
}
