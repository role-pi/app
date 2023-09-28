import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/evento_edit_provider.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_map.dart';
import 'package:role/features/evento_detail/providers/evento_detail_provider.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_date_picker.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventoEditScreen extends StatelessWidget {
  EventoEditScreen(EventoDetailProvider eventoDetailProvider) {
    this.eventoEditProvider = EventoEditProvider(eventoDetailProvider);
  }

  late EventoEditProvider eventoEditProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: eventoEditProvider,
        child: CupertinoPageScaffold(
          child: SingleChildScrollView(
            child: Column(children: [
              Consumer<EventoEditProvider>(builder: (context, provider, child) {
                return CustomNavigationBar(
                    trailingText: "salvar",
                    onPressedLeading: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTrailing: provider.changed
                        ? () {
                            provider.updateData(context);
                          }
                        : null,
                    accentColor: provider.evento.color1);
              }),
              Form(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Column(
                    children: [
                      FormItemGroupTitle(title: "INFORMAÇÕES"),
                      FormItemTextField(
                          controller: eventoEditProvider.nameController,
                          title: eventoEditProvider.evento.name),
                      SizedBox(height: 12),
                      Row(children: [
                        Consumer<EventoEditProvider>(
                            builder: (context, provider, child) {
                          return FormItemDatePicker(
                            dateTime: provider.evento.dataInicio,
                            onDateTimeChanged: provider.setDataInicio,
                            title: 'data de início',
                          );
                        }),
                        SizedBox(width: 12),
                        Icon(CupertinoIcons.arrow_right,
                            size: 30,
                            color: CupertinoColors.systemGrey3
                                .resolveFrom(context)),
                        SizedBox(width: 12),
                        Consumer<EventoEditProvider>(
                            builder: (context, provider, child) {
                          return FormItemDatePicker(
                            dateTime: provider.evento.dataFim,
                            onDateTimeChanged: provider.setDataFim,
                            title: 'data de fim',
                          );
                        }),
                      ]),
                      SizedBox(height: 12),
                      SizedBox(
                          height: 250,
                          child: EventoDetailMap(
                              color: eventoEditProvider.evento.color1,
                              endereco: eventoEditProvider.evento.endereco)),
                      SizedBox(height: 12),
                      FormItemGroupTitle(title: "5 CONVIDADOS"),
                      SizedBox(height: 12),
                      RoundButton(
                        onPressed: () async {
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text("Atenção!"),
                              content: const Text(
                                  "Certeza que Deseja Excluir esse Evento?"),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text("Não"),
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text("Sim"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        textColor: CupertinoColors.white,
                        rectangleColor: CupertinoColors.systemRed,
                        text: 'excluir evento',
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
