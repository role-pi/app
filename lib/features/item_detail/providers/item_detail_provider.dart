import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/features/item_detail/repository/item_detail_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/transaction.dart';

class ItemDetailProvider extends ChangeNotifier {
  late int id;
  late EventDetailProvider eventDetailProvider;

  Item get item => eventDetailProvider.item(id);
  Event get event => eventDetailProvider.event;

  ItemDetailRepository itemRepository = ItemDetailRepository();

  FToast fToast = FToast();

  ItemDetailProvider(int id, int eventId) {
    this.eventDetailProvider = EventDetailProvider(eventId);
    this.id = id;
    get();
  }

  updateItem(Item? item) {
    if (item == null) return;
    this.item.nome = item.nome;
    this.item.valor = item.valor;
    this.item.tipo = item.tipo;
    this.item.descricao = item.descricao;
    this.item.data = item.data;

    notifyListeners();
    EventListProvider.shared.notifyListeners();
  }

  setTransactions(List<Transaction> transactions) {
    item.transacoes = transactions;
  }

  get() async {
    updateItem(await itemRepository.getItem(item));
    setTransactions(await itemRepository.getTransactions(item));
    print(item.transacoes.length);
    notifyListeners();
  }
}
