class HttpErrorResponseException implements Exception {
  final dynamic _decodedResponseBody;
  HttpErrorResponseException(this._decodedResponseBody);

  get responseBody => _decodedResponseBody;
}
