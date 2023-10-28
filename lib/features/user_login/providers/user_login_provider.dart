import 'package:flutter/cupertino.dart';
import 'package:role/features/user_login/repository/user_repository.dart';
import 'package:role/models/user.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLoginProvider extends ChangeNotifier {
  LoginState _state = LoginState.loggedOut;
  LoginState get state => _state;

  String? _token = "";
  String? get token => _token;

  User? _user;
  User? get user => _user;

  bool _failed = false;
  bool get failed => _failed;

  final _codeController = TextEditingController();
  TextEditingController get codeController => _codeController;

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

      User? user = await userRepository.authenticate();

      if (user != null) {
        setState(LoginState.loggedIn);
        setUser(user);
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
      var (user, token) = await userRepository.verify(email, code);

      if (user != null && token != null) {
        _token = token;
        saveToken(_token);

        _user = user;

        setState(LoginState.loggingIn);
        callback();
      } else {
        codeController.clear();
        _failed = true;
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
