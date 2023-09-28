import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/evento_detail/providers/evento_detail_provider.dart';
import 'package:role/features/evento_detail/screens/evento_map_screen.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_guests.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_header.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_insumos.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_map.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/features/new_insumo/screens/new_insumo_screen.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_inputs.dart';

class EventoDetailScreen extends StatelessWidget {
  EventoDetailScreen({required this.id})
      : eventoDetailProvider =
            EventoDetailProvider(EventoListProvider.shared, id);

  final int id;
  final EventoDetailProvider eventoDetailProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: eventoDetailProvider,
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
                    Consumer<EventoDetailProvider>(
                      builder: (context, provider, child) {
                        if (provider.evento.usuarios != null) {
                          return EventDetailGuests(
                              convidados: provider.evento.usuarios!);
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 24),
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
                    SizedBox(height: 24),
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
                                  builder: (context) =>
                                      NewInsumoScreen(eventoDetailProvider)),
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
                      // EventDetailInputs(),
                      ],
                    ),
                    SizedBox(height: 24),
                    Consumer<EventoDetailProvider>(
                      builder: (context, provider, child) {
                        if (provider.evento.insumos != null) {
                          return EventoDetailInsumos(
                              insumos: provider.evento.insumos!);
                        }
                        return Container();
                      },
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
