import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_detail/widgets/event_detail_map.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_date_picker.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventEditScreen extends StatelessWidget {
  EventEditScreen(EventDetailProvider eventoDetailProvider) {
    this.eventoEditProvider = EventEditProvider(eventoDetailProvider);
  }

  late final EventEditProvider eventoEditProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: eventoEditProvider,
        child: CupertinoPageScaffold(
          child: SingleChildScrollView(
            child: Column(children: [
              Consumer<EventEditProvider>(builder: (context, provider, child) {
                return CustomNavigationBar(
                    trailingText: "salvar",
                    onPressedLeading: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTrailing: provider.changed
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              provider.updateData(context);
                            }
                          }
                        : null,
                    accentColor: provider.event.color1);
              }),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Column(
                    children: [
                      FormItemGroupTitle(title: "INFORMAÇÕES"),
                      FormItemTextField(
                        controller: eventoEditProvider.nameController,
                        title: eventoEditProvider.event.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O nome não pode ser vazio.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      Row(children: [
                        FormItemDatePicker(
                          title: "data de início",
                          initialValue: eventoEditProvider.event.startDate,
                          onSaved: eventoEditProvider.setDataInicio,
                        ),
                        SizedBox(width: 12),
                        Icon(CupertinoIcons.arrow_right,
                            size: 30,
                            color: CupertinoColors.systemGrey3
                                .resolveFrom(context)),
                        SizedBox(width: 12),
                        FormItemDatePicker(
                          title: "data de fim",
                          initialValue: eventoEditProvider.event.endDate,
                          onSaved: eventoEditProvider.setDataFim,
                        ),
                      ]),
                      SizedBox(height: 12),
                      SizedBox(
                          height: 250,
                          child: EventDetailMap(
                              color: eventoEditProvider.event.color1,
                              endereco: eventoEditProvider.event.endereco)),
                      SizedBox(height: 12),
                      FormItemGroupTitle(title: "5 CONVIDADOS"),
                      SizedBox(height: 12),
                      RoundButton(
                        onPressed: () async {
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text("tem certeza?"),
                              content: const Text(
                                  "essa ação não poderá ser desfeita"),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text("cancelar"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text("excluir evento"),
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    eventoEditProvider.delete(context);
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
