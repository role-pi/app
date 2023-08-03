import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                padding: const EdgeInsets.only(top: 48),
                child: CustomScrollView(slivers: [
                  CupertinoSliverRefreshControl(onRefresh: () async {
                    usersViewModel.get();
                  }),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == 0) {
                        // Align to the left
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(38, 38, 38, 12),
                          child: Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:
                                    Image.asset('assets/Logo.png', height: 50),
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  "próximos eventos",
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.black
                                          .withAlpha((255 * 0.2).toInt()),
                                      letterSpacing: -1.5),
                                ),
                              ),
                            ],
                          )),
                        );
                      } else {
                        Evento evento = usersViewModel.eventos[index - 1];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 4.0),
                          child: EventoItemRow(
                            evento: evento,
                          ),
                        );
                      }
                    }, childCount: usersViewModel.eventos.length + 1),
                  )
                ]),
              ),
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
