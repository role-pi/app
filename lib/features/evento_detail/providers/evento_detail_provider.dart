import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_detail/repository/evento_detail_repository.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/models/insumo.dart';
import 'package:role/models/usuario.dart';

class EventoDetailProvider extends ChangeNotifier {
  late Evento evento;

  EventoDetailRepository eventoRepository = EventoDetailRepository();

  EventoDetailProvider(int id) {
    evento = EventoListProvider.shared.evento(id);
    get();
  }

  setInsumos(List<Insumo> insumos) {
    evento.insumos = insumos;
  }

  setUsuarios(List<Usuario> usuarios) {
    evento.usuarios = usuarios;
  }

  get() async {
    evento = await eventoRepository.getEvento(evento) ?? evento;
    setInsumos(await eventoRepository.getInsumos(evento));
    setUsuarios(await eventoRepository.getUsuarios(evento));

    notifyListeners();
  }

  delete(Evento evento, BuildContext context) async {
    // await EventoListProvider.shared.delete(evento, context);
  }
}
