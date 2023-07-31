import 'package:flutter/cupertino.dart';
import 'package:role/models/evento.dart';
import 'package:role/controllers/api_status.dart';
import 'package:role/controllers/services.dart';

class EventosListViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Evento> _usuarios = [];
  // Failure _userError;

  bool get loading => _loading;
  List<Evento> get eventos => _usuarios;
  // Failure get userError => _userError;

  EventosListViewModel() {
    get();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  set(List<Evento> userListModel) {
    _usuarios = userListModel;
  }

  setUserError(Failure userError) {
    // _userError = userError;
  }

  get() async {
    setLoading(true);
    var response = await Services.getEventos();
    if (response is Success) {
      set(response.response as List<Evento>);
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
