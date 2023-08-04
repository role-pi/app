import 'package:flutter/cupertino.dart';
import 'package:role/controllers/eventos_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/views/home/evento_item_row.dart';

import '../views/home/home_header.dart';
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
                          child: HomeHeader(),
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
