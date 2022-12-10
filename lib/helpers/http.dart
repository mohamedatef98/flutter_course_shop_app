import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_4/helpers/http_error_response_exception.dart';

Future<Map<String, dynamic>> get(Uri uri) {
  return http.get(
    uri,
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    var decodedResponse;
    if (response.body == 'null') {
      decodedResponse = <String, dynamic>{};
    }
    else {
      decodedResponse = jsonDecode(response.body);
    }
    if (response.statusCode >= 400) {
      throw HttpErrorResponseException(decodedResponse);
    }
    return decodedResponse;
  });
}

Future<Map<String, dynamic>> delete(Uri uri) {
  return http.delete(
    uri,
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    var decodedResponse;
    if (response.body == 'null') {
      decodedResponse = <String, dynamic>{};
    }
    else {
      decodedResponse = jsonDecode(response.body);
    }
    if (response.statusCode >= 400) {
      throw HttpErrorResponseException(decodedResponse);
    }
    return decodedResponse;
  });
}

Future<Map<String, dynamic>> post(Uri uri, dynamic body) {
  return http.post(
    uri,
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    var decodedResponse;
    if (response.body == 'null') {
      decodedResponse = <String, dynamic>{};
    }
    else {
      decodedResponse = jsonDecode(response.body);
    }
    if (response.statusCode >= 400) {
      throw HttpErrorResponseException(decodedResponse);
    }
    return decodedResponse;
  });
}

Future<Map<String, dynamic>> patch(Uri uri, dynamic body) {
  return http.patch(
    uri,
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json'
    }
  ).then((response) {
    var decodedResponse;
    if (response.body == 'null') {
      decodedResponse = <String, dynamic>{};
    }
    else {
      decodedResponse = jsonDecode(response.body);
    }
    if (response.statusCode >= 400) {
      throw HttpErrorResponseException(decodedResponse);
    }
    return decodedResponse;
  });
}
