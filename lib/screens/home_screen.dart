import 'package:flutter/cupertino.dart';
import 'package:role/controllers/eventos_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/views/evento_item_row.dart';

import '../views/round_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventosListViewModel usersViewModel = context.watch<EventosListViewModel>();

    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ListView.builder(
                    itemCount: usersViewModel.eventos.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Align to the left
                        return Expanded(
                            child: Container(
                          child: Image.asset('assets/Logo.png', height: 45),
                          alignment: Alignment.centerLeft,
                        ));
                      } else {
                        Evento evento = usersViewModel.eventos[index];
                        return EventoItemRow(
                          evento: evento,
                        );
                      }
                    },
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: RoundButton(onTap: () {
                  usersViewModel.get();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
