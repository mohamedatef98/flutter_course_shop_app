import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> get(Uri uri) {
  return http.get(
    uri,
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    if (response.statusCode >= 400) {
      throw Exception('Status code is ${response.statusCode}');
    }
    if (response.body == 'null') return {};
    return jsonDecode(response.body);
  });
}

Future<Map<String, dynamic>> delete(Uri uri) {
  return http.delete(
    uri,
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    if (response.statusCode >= 400) {
      throw Exception('Status code is ${response.statusCode}');
    }
    return {};
  });
}

Future<Map<String, dynamic>> post(Uri uri, Map<String, dynamic> body) {
  return http.post(
    uri,
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    if (response.statusCode >= 400) {
      throw Exception('Status code is ${response.statusCode}');
    }
    return jsonDecode(response.body);
  });
}

Future<Map<String, dynamic>> patch(Uri uri, Map<String, dynamic> body) {
  return http.patch(
    uri,
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    if (response.statusCode >= 400) {
      throw Exception('Status code is ${response.statusCode}');
    }
    return jsonDecode(response.body);
  });
}
