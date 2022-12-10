import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:project_4/helpers/env.dart';
import 'package:project_4/helpers/http_error_response_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/http.dart' as http;

class AuthModel extends ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  static const String _userIdTag = 'USER_ID';

  static const String _tokenTag = 'TOKEN';

  static const String _expiryDateTag = 'EXPIRY_DATE';

  static const _errorMessages = {
    'EMAIL_EXISTS': 'Email is already used.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Too many attempts, Please try again later.',
    'EMAIL_NOT_FOUND': 'Email is invalid.',
    'INVALID_PASSWORD': 'Password is invalid.',
    'USER_DISABLED': 'Account Disabled.'
  };

  static const _somethingWrong = "Something went wrong";

  AuthModel() {
    SharedPreferences.getInstance().then((instance) {
      final containsExpiryDate = instance.containsKey(_expiryDateTag);
      if (containsExpiryDate == true) {
        final expiryDateString = instance.getString(_expiryDateTag)!;
        final expiryDate = DateTime.parse(expiryDateString);
        final now = DateTime.now();
        if(now.isBefore(expiryDate)) {
          _expiryDate = expiryDate;
          _token = instance.getString(_tokenTag);
          _userId = instance.getString(_userIdTag);

          notifyListeners();
          _setAuthTimer(expiryDate.difference(now).inSeconds);
        }
      }
    });
  }

  void _manageAuthResponse(Map<String, dynamic> response) async {
    final expiresIn = int.parse(response['expiresIn']);
    _token = response['idToken'];
    _userId = response['localId'];
    _expiryDate = DateTime.now().add(Duration(seconds: expiresIn));
    notifyListeners();

    _storeAuthInfo();
    _setAuthTimer(expiresIn);
  }

  void _storeAuthInfo() async {
    final sharedPreferencesInstance = await SharedPreferences.getInstance();
    sharedPreferencesInstance.setString(_tokenTag, _token!);
    sharedPreferencesInstance.setString(_userIdTag, _userId!);
    sharedPreferencesInstance.setString(_expiryDateTag, _expiryDate!.toIso8601String());
  }

  void _clearAuthInfo() async {
    final sharedPreferencesInstance = await SharedPreferences.getInstance();
    sharedPreferencesInstance.remove(_tokenTag);
    sharedPreferencesInstance.remove(_userIdTag);
    sharedPreferencesInstance.remove(_expiryDateTag);
  }

  void _setAuthTimer(int expiresIn) {
    if(_authTimer != null) {
      _authTimer!.cancel();
    }

    _authTimer = Timer(
      Duration(seconds: expiresIn),
      logout
    );
  }

  String getToken() {
    if(_token == null) {
      throw Exception("Not Authenticated");
    }
    else {
      return _token!;
    }
  }

  String getUserId() {
    if(_token == null) {
      throw Exception("Not Authenticated");
    }
    else {
      return _userId!;
    }
  }

  bool isAuthenticated() {
    if ((_token != null) && (DateTime.now().isBefore(_expiryDate!))) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> signup(String email, String password) async {
    final signupUri = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
    try {
      final response = await http.post(
        signupUri,
        {
          'email': email,
          'password': password,
          'returnSecureToken': true
        }
      );
      _manageAuthResponse(response);
    } on HttpErrorResponseException catch(errorResponse) {
      final errorMessage = errorResponse.responseBody['error']['message'];
      throw _errorMessages[errorMessage] ?? _somethingWrong;
    } catch(error) {
      throw _somethingWrong;
    }
  }

  Future<void> login(String email, String password) async {
    final loginUri = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
    try {
      final response = await http.post(
        loginUri,
        {
          'email': email,
          'password': password,
          'returnSecureToken': true
        }
      );
      _manageAuthResponse(response);
    } on HttpErrorResponseException catch(errorResponse) {
      final errorMessage = errorResponse.responseBody['error']['message'];
      throw _errorMessages[errorMessage] ?? _somethingWrong;
    } catch(error) {
      throw _somethingWrong;
    }
  }

  void logout() {
    _token = null;
    _expiryDate = null;
    _userId = null;

    if(_authTimer != null) {
      _authTimer!.cancel();
    }
    _authTimer = null;

    _clearAuthInfo();

    notifyListeners();
  }
}
