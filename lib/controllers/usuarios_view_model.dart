import 'package:flutter/cupertino.dart';
import 'package:role/models/usuario.dart';
import 'package:role/controllers/api_status.dart';
import 'package:role/controllers/services.dart';

class UsuariosViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Usuario> _usuarios = [];
  // Failure _userError;

  bool get loading => _loading;
  List<Usuario> get usuarios => _usuarios;
  // Failure get userError => _userError;

  UsuariosViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUsuarios(List<Usuario> userListModel) {
    _usuarios = userListModel;
  }

  setUserError(Failure userError) {
    // _userError = userError;
  }

  getUsers() async {
    setLoading(true);
    var response = await Services.getUsers();
    if (response is Success) {
      setUsuarios(response.response as List<Usuario>);
    }
    if (response is Failure) {
      print(response.errorResponse);
      // UserError userError = UserError(
      //   code: response.code,
      //   message: response.errorResponse,
      // );
      // setUserError(userError);
    }
    setLoading(false);
  }
}
