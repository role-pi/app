import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class UserLoginProvider extends ChangeNotifier {
  // Replace this with your API URL.
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> tryLogin() async {
    // Implement a function to get the JWT token from device storage.
    if (!isLoggedIn) {
      var response = await API().post("usuario/login", {});

      if (response is Success) {
        if (json.decode(response.response as String).containsKey("user")) {
          _isLoggedIn = true;
          notifyListeners();
          print("AAAAAA");
        }
      } else if (response is Failure) {
        // Login failed.
        _isLoggedIn = false;
        notifyListeners();
      }
    }
  }
}
