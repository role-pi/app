import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_detail/screens/evento_map_screen.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_header.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_map.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/features/new_insumo/screens/new_insumo_screen.dart';
import 'package:role/models/endereco.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventoDetailScreen extends StatelessWidget {
  EventoDetailScreen({required this.id})
      : evento = EventoListProvider.shared.evento(id);

  final int id;
  final Evento evento;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: false,
              delegate: EventoDetailHeaderDelegate(evento: evento)),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                RoundButton(
                  text: "adicionar insumo",
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NewInsumoScreen(id: id)));
                    // Navigator.pushNamed(context, "/evento/1/insumo");
                  },
                  rectangleColor: CupertinoColors.systemGrey6,
                  textColor: CupertinoColors.label,
                ),
                SizedBox(height: 16),
                ElasticButton(
                    child: SizedBox(
                      height: 200,
                      child: EventoDetailMap(
                        color: evento.color2,
                        endereco: evento.endereco,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EventoMapScreen(
                                  color: evento.color2,
                                  endereco: evento.endereco)));
                    })
              ],
            ),
          ))
        ],
      ),
    );
  }
}
