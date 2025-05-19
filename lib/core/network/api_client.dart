// ogólna klasa do zapytań HTTP
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Klient API obsługujący zapytania HTTP GET, POST itd.
class ApiClient {
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Wysyła żądanie GET
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse(url),
      headers: headers ?? _defaultHeaders,
    );

    return _processResponse(response);
  }

  /// Wysyła żądanie POST
  Future<dynamic> post(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers ?? _defaultHeaders,
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  /// Wysyła żądanie PUT
  Future<dynamic> put(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    final response = await http.put(
      Uri.parse(url),
      headers: headers ?? _defaultHeaders,
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  /// Wysyła żądanie DELETE
  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: headers ?? _defaultHeaders,
    );

    return _processResponse(response);
  }

  /// Przetwarza odpowiedź i rzuca wyjątki w przypadku błędów
  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return body;
    } else {
      throw HttpException(
        'Request failed: ${response.statusCode}',
        statusCode: statusCode,
        responseBody: body,
      );
    }
  }
}

/// Prosty wyjątek HTTP do obsługi błędów
class HttpException implements Exception {
  final String message;
  final int statusCode;
  final dynamic responseBody;

  HttpException(this.message, {required this.statusCode, this.responseBody});

  @override
  String toString() => 'HttpException ($statusCode): $message\n$responseBody';
}
