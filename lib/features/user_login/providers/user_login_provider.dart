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
      var response = await API().post("usuario/login", {});

      if (response is Success) {
        Map decoded = json.decode(response.response as String);
        if (decoded.containsKey("user")) {
          setState(LoginState.loggedIn);
          setUser(Usuario.fromJson(decoded["user"]));

          callback();
          notifyListeners();
        } else {
          setState(LoginState.signUp);
          notifyListeners();
        }
      } else if (response is Failure) {
        setState(LoginState.signUp);
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

      // if (response is Success) {
      //   Map decoded = json.decode(response.response as String);
      //   if (decoded.containsKey("user")) {
      //     _state = LoginState.loggedIn;
      //     notifyListeners();
      //     callback();
      //   }
      // } else if (response is Failure) {
      //   _state = LoginState.signUp;
      //   notifyListeners();
      // }

      print(_state);
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

          setState(LoginState.loggingIn);
          callback();
          notifyListeners();
        }
      } else if (response is Failure) {
        setState(LoginState.signUp);
        notifyListeners();
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
  signUp,
  verifying,
  loggedIn,
}
