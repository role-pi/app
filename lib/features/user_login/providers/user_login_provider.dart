import 'package:flutter/material.dart';
import 'package:role/features/user_login/repository/user_repository.dart';
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

  UserRepository userRepository = UserRepository();

  static final UserLoginProvider shared = UserLoginProvider();

  final storage = new FlutterSecureStorage();

  UserLoginProvider() {
    storage.read(key: "token").then((value) => {_token = value});
  }

  void setState(state) {
    _state = state;
    notifyListeners();
  }

  void setUser(user) {
    _user = user;
    notifyListeners();
  }

  Future<void> tryAuthentication(callback) async {
    if (state == LoginState.loggedOut) {
      _token = await storage.read(key: "token");

      Usuario? usuario = await userRepository.authenticate();

      if (usuario != null) {
        setState(LoginState.loggedIn);
        setUser(usuario);
        callback();
      } else {
        setState(LoginState.signIn);
      }

      notifyListeners();
    }
  }

  Future<void> trySignUp(email, callback) async {
    if (state == LoginState.signIn) {
      try {
        var response = await API().request(
            endpoint: "usuario/signin", method: "POST", body: {"email": email});

        Map decoded = json.decode(response.response);
        if (decoded.containsKey("user")) {
          setState(LoginState.loggedIn);
          callback();
        } else {
          setState(LoginState.verify);
        }
      } catch (e) {
        setState(LoginState.signIn);
        notifyListeners();

        if (e is ApiError) {
          print('Error Code: ${e.code}, Message: ${e.message}');
        } else {
          print('Unknown error occurred: $e');
        }
      }
    }
  }

  Future<void> verify(email, code, callback) async {
    if (state != LoginState.loggedIn) {
      try {
        var response = await API().request(
            endpoint: "usuario/verify",
            method: "POST",
            body: {"email": email, "code": code});

        Map decoded = json.decode(response.response);
        if (decoded.containsKey("user") && decoded.containsKey("token")) {
          _token = decoded["token"];
          saveToken(_token);

          _user = Usuario.fromJson(decoded["user"]);

          setState(LoginState.loggingIn);
          callback();
          notifyListeners();
        }
      } catch (e) {
        setState(LoginState.signIn);
        notifyListeners();

        if (e is ApiError) {
          print('Error Code: ${e.code}, Message: ${e.message}');
        } else {
          print('Unknown error occurred: $e');
        }
      }
    }
  }

  void logout() async {
    await storage.delete(key: "token");
    setState(LoginState.loggedOut);
  }

  void saveToken(token) async {
    await storage.write(key: "token", value: token);
  }
}

enum LoginState {
  loggedOut,
  loggingIn,
  signIn,
  verify,
  loggedIn,
}
