import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_detail/repository/evento_detail_repository.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/models/insumo.dart';
import 'package:role/models/usuario.dart';

class EventoDetailProvider extends ChangeNotifier {
  late int id;
  late EventoListProvider eventoListProvider;

  Evento get evento => eventoListProvider.evento(id);

  EventoDetailRepository eventoRepository = EventoDetailRepository();

  EventoDetailProvider(EventoListProvider eventoListProvider, int id) {
    this.eventoListProvider = eventoListProvider;
    this.id = id;
    get();
  }

  updateEvento(Evento? evento) {
    if (evento == null) return;
    this.evento.name = evento.name;
    this.evento.dataInicio = evento.dataInicio;
    this.evento.dataFim = evento.dataFim;
    this.evento.valorTotal = evento.valorTotal;
    this.evento.theme = evento.theme;
  }

  setInsumos(List<Insumo> insumos) {
    evento.insumos = insumos;
  }

  setUsuarios(List<Usuario> usuarios) {
    evento.usuarios = usuarios;
  }

  get() async {
    updateEvento(await eventoRepository.getEvento(evento));
    setInsumos(await eventoRepository.getInsumos(evento));
    setUsuarios(await eventoRepository.getUsuarios(evento));

    notifyListeners();
  }

  delete(Evento evento, BuildContext context) async {
    // await EventoListProvider.shared.delete(evento, context);
  }
}
