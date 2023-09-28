import 'package:flutter/cupertino.dart';
import 'package:role/features/user_login/repository/user_repository.dart';
import 'package:role/models/usuario.dart';

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

  Future tryAuthentication(callback) async {
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

  Future trySignUp(email, callback) async {
    if (state == LoginState.signIn) {
      var existing = await userRepository.signUp(email);

      if (existing != null) {
        setState(LoginState.verify);
      } else {
        setState(LoginState.signIn);
      }

      notifyListeners();
    }
  }

  Future verify(email, code, callback) async {
    if (state != LoginState.loggedIn) {
      var (usuario, token) = await userRepository.verify(email, code);

      if (usuario != null && token != null) {
        _token = token;
        saveToken(_token);

        _user = usuario;

        setState(LoginState.loggingIn);
        callback();
      } else {
        setState(LoginState.signIn);
      }

      notifyListeners();
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
