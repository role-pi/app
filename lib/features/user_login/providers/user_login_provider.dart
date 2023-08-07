import 'package:flutter/material.dart';
import 'package:role/features/user_login/domain/models/usuario.dart';
import 'dart:convert';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLoginProvider extends ChangeNotifier {
  LoginState _state = LoginState.signUp;
  LoginState get state => _state;

  String? _token = "";
  String? get token => _token;

  Usuario? _user;
  Usuario? get user => _user;

  static final UserLoginProvider shared = UserLoginProvider();

  final storage = new FlutterSecureStorage();

  UserLoginProvider() {
    storage
        .read(key: "token")
        .then((value) => null != value ? _token = value : null);
  }

  Future<void> tryAuthentication(callback) async {
    if (state != LoginState.loggedIn) {
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
        notifyListeners();
      }
    }
  }

  Future<void> trySignUp(email, callback) async {
    if (state != LoginState.loggedIn) {
      var response = await API().post("usuario/signin", {"email": email});

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

  void saveToken(token) async {
    await storage.write(key: "token", value: token);
  }
}

enum LoginState {
  loggingIn,
  loggedIn,
  signUp,
}
