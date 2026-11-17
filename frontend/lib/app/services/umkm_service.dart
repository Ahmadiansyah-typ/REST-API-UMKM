import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/umkm_model.dart';

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode, this.errors});

  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  @override
  String toString() => message;
}

class UmkmService {
  UmkmService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // Android Emulator: 10.0.2.2 mengarah ke localhost komputer host.
  // Ganti melalui --dart-define untuk iOS Simulator atau perangkat fisik.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080/api',
  );

  Uri _endpoint([String suffix = '']) {
    final normalizedBase = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    return Uri.parse(
        '$normalizedBase${suffix.replaceFirst(RegExp(r'^/'), '')}');
  }

  Future<List<Umkm>> getUmkmList() async {
    final response = await _client.get(
      _endpoint('umkm'),
      headers: const {'Accept': 'application/json'},
    ).timeout(const Duration(seconds: 15));

    final json = _decodeResponse(response);
    if (response.statusCode != 200 || json['success'] != true) {
      throw _apiException(response.statusCode, json);
    }

    final rawData = json['data'];
    if (rawData is! List) {
      throw const ApiException('Format data dari server tidak sesuai.');
    }

    return rawData
        .whereType<Map>()
        .map((item) => Umkm.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<Map<String, dynamic>> createUmkm(Umkm umkm) async {
    final response = await _client
        .post(
          _endpoint('umkm'),
          headers: const {
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: umkm.toFormData(),
        )
        .timeout(const Duration(seconds: 15));

    final json = _decodeResponse(response);
    if ((response.statusCode != 200 && response.statusCode != 201) ||
        json['success'] != true) {
      throw _apiException(response.statusCode, json);
    }
    return json;
  }

  Future<Map<String, dynamic>> updateUmkm(int id, Umkm umkm) async {
    final response = await _client
        .put(
          _endpoint('umkm/$id'),
          headers: const {
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: umkm.toFormData(),
        )
        .timeout(const Duration(seconds: 15));

    final json = _decodeResponse(response);
    if (response.statusCode != 200 || json['success'] != true) {
      throw _apiException(response.statusCode, json);
    }
    return json;
  }

  Future<Map<String, dynamic>> deleteUmkm(int id) async {
    final response = await _client.delete(
      _endpoint('umkm/$id'),
      headers: const {'Accept': 'application/json'},
    ).timeout(const Duration(seconds: 15));

    final json = _decodeResponse(response);
    if (response.statusCode != 200 || json['success'] != true) {
      throw _apiException(response.statusCode, json);
    }
    return json;
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      throw const FormatException('Response JSON bukan object.');
    } on FormatException {
      throw ApiException(
        'Server mengirim response yang bukan JSON valid (HTTP ${response.statusCode}).',
        statusCode: response.statusCode,
      );
    }
  }

  ApiException _apiException(int statusCode, Map<String, dynamic> json) {
    final message = (json['message'] ?? 'Request API gagal').toString();
    final rawErrors = json['errors'];
    return ApiException(
      message,
      statusCode: statusCode,
      errors: rawErrors is Map ? Map<String, dynamic>.from(rawErrors) : null,
    );
  }
}
