import 'package:flutter/material.dart';
import 'package:role/models/usuario.dart';
import 'dart:convert';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLoginProvider extends ChangeNotifier {
  LoginState _state = LoginState.loggedOut;
  LoginState get state => _state;

  String? _token = "";
  String? get token => _token;

  Usuario? _user;
  Usuario? get user => _user;

  static final UserLoginProvider shared = UserLoginProvider();

  final storage = new FlutterSecureStorage();

  UserLoginProvider() {
    storage.read(key: "token").then((value) => {_token = value});
  }

  Future<void> tryAuthentication(callback) async {
    if (state == LoginState.loggedOut) {
      _token = await storage.read(key: "token");
      var response = await API().post("usuario/login", {});

      if (response is Success) {
        Map decoded = json.decode(response.response as String);
        if (decoded.containsKey("user")) {
          _state = LoginState.loggedIn;

          _user = Usuario.fromJson(decoded["user"]);

          callback();
          notifyListeners();
        }
      } else if (response is Failure) {
        _state = LoginState.signUp;
        print(response.errorResponse);
        notifyListeners();
      }
    }
  }

  Future<void> trySignUp(email, callback) async {
    if (state != LoginState.loggedIn) {
      var response = await API().post("usuario/signin", {"email": email});

      _state = LoginState.verifying;
      notifyListeners();

      if (response is Success) {
        Map decoded = json.decode(response.response as String);
        if (decoded.containsKey("user")) {
          _state = LoginState.loggedIn;
          notifyListeners();
          callback();
        }
      } else if (response is Failure) {
        _state = LoginState.signUp;
        notifyListeners();
      }
    }
  }

  Future<void> verify(email, code, callback) async {
    if (state != LoginState.loggedIn) {
      var response =
          await API().post("usuario/verify", {"email": email, "code": code});

      if (response is Success) {
        Map decoded = json.decode(response.response as String);
        if (decoded.containsKey("user") && decoded.containsKey("token")) {
          _token = decoded["token"];
          saveToken(_token);

          _user = Usuario.fromJson(decoded["user"]);

          _state = LoginState.loggedIn;
          callback();
          notifyListeners();
        }
      } else if (response is Failure) {
        _state = LoginState.signUp;
        notifyListeners();
      }
    }
  }

  void logout() async {
    await storage.delete(key: "token");
    _state = LoginState.loggedOut;
  }

  void saveToken(token) async {
    await storage.write(key: "token", value: token);
  }
}

enum LoginState {
  loggedOut,
  loggingIn,
  signUp,
  verifying,
  loggedIn,
}
