import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/evento_detail/providers/evento_detail_provider.dart';
import 'package:role/features/evento_detail/screens/evento_map_screen.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_guests.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_header.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_map.dart';
import 'package:role/features/new_insumo/screens/new_insumo_screen.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class EventoDetailScreen extends StatelessWidget {
  EventoDetailScreen({required this.id})
      : eventoDetailProvider = EventoDetailProvider(id);

  final int id;
  final EventoDetailProvider eventoDetailProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => eventoDetailProvider,
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: EventoDetailHeaderDelegate(
                  evento: eventoDetailProvider.evento),
            ),
            CupertinoSliverRefreshControl(onRefresh: () async {
              await eventoDetailProvider.get();
            }),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    eventoDetailProvider.evento.usuarios != null
                        ? EventDetailGuests(
                            convidados: eventoDetailProvider.evento.usuarios!)
                        : Container(),
                    SizedBox(height: 25),
                    ElasticButton(
                      child: SizedBox(
                        height: 200,
                        child: EventoDetailMap(
                          color: eventoDetailProvider.evento.color2,
                          endereco: eventoDetailProvider.evento.endereco,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => EventoMapScreen(
                              color: eventoDetailProvider.evento.color2,
                              endereco: eventoDetailProvider.evento.endereco,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insumos",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                          ),
                        ),
                        ElasticButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NewInsumoScreen(id: id),
                              ),
                            );
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.systemGrey6, context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add,
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.label, context),
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
