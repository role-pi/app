import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_detail/repository/evento_detail_repository.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/models/insumo.dart';
import 'package:role/models/usuario.dart';

class EventoDetailProvider extends ChangeNotifier {
  bool _loading = false;
  late Evento evento;

  EventoDetailRepository eventoRepository = EventoDetailRepository();

  bool get loading => _loading;

  EventoDetailProvider(int id) {
    evento = EventoListProvider.shared.evento(id);
    get();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  updateEvento(Evento? evento) {
    if (evento == null) return;
    this.evento.name = evento.name;
    this.evento.dataInicio = evento.dataInicio;
    this.evento.dataFim = evento.dataFim;
    this.evento.valorTotal = evento.valorTotal;
    this.evento.theme = evento.theme;
    notifyListeners();

    EventoListProvider.shared.notifyListeners();
  }

  setInsumos(List<Insumo> insumos) {
    evento.insumos = insumos;
    notifyListeners();
  }

  setUsuarios(List<Usuario> usuarios) {
    evento.usuarios = usuarios;
    notifyListeners();
  }

  get() async {
    setInsumos(await eventoRepository.getInsumos(evento));
    setUsuarios(await eventoRepository.getUsuarios(evento));
  }

  delete(Evento evento, BuildContext context) async {
    // await EventoListProvider.shared.delete(evento, context);
  }
}
