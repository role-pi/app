import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/evento_edit_provider.dart';
// import 'package:flutter/material.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_map.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventoEditScreen extends StatelessWidget {
  EventoEditScreen({required this.id})
      : eventoEditProvider = EventoEditProvider(id);

  final int id;
  final EventoEditProvider eventoEditProvider;

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
                            eventoEditProvider.updateData(context);
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

class FormItemDatePicker extends StatelessWidget {
  const FormItemDatePicker(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.onDateTimeChanged});

  final String title;
  final DateTime? dateTime;
  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElasticButton(
        onTap: () => _showDialog(
          context,
          CupertinoDatePicker(
              initialDateTime: dateTime,
              use24hFormat: true,
              onDateTimeChanged: onDateTimeChanged),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey6, context),
              borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text(
              dateTime == null
                  ? ""
                  : '${dateTime!.day}/${dateTime!.month} ${dateTime!.hour}:${dateTime!.minute}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.0,
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              )),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 320,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: CupertinoColors.systemBackground.resolveFrom(context),
        ),
        child: SafeArea(
          top: false,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2,
                    color: CupertinoColors.label.resolveFrom(context),
                  ),
                )),
            SizedBox(height: 200, child: child)
          ]),
        ),
      ),
    );
  }
}

class FormItemTextField extends StatelessWidget {
  const FormItemTextField({required this.controller, required this.title});

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(
              CupertinoColors.systemGrey6, context),
          borderRadius: BorderRadius.circular(12.0)),
      child: CupertinoTextFormFieldRow(
        padding: const EdgeInsets.all(8.0),
        controller: controller,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
        ),
      ),
    );
  }
}

class FormItemGroupTitle extends StatelessWidget {
  const FormItemGroupTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.9,
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey2, context),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
