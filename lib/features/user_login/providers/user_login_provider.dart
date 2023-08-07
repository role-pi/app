import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class UserLoginProvider extends ChangeNotifier {
  LoginState _state = LoginState.signUp;

  LoginState get state => _state;

  Future<void> tryAuthentication(callback) async {
    if (state != LoginState.loggedIn) {
      var response = await API().post("usuario/login", {});

      if (response is Success) {
        if (json.decode(response.response as String).containsKey("user")) {
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

  Future<void> trySignUp(email, callback) async {
    if (state != LoginState.loggedIn) {
      var response = await API().post("usuario/signin", {"email": email});

      if (response is Success) {
        if (json.decode(response.response as String).containsKey("user")) {
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

      print(response);

      if (response is Success) {
        if (json.decode(response.response as String).containsKey("user")) {
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
}

enum LoginState {
  loggingIn,
  loggedIn,
  signUp,
}
