import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_detail/widgets/event_detail_map.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_date_picker.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventEditScreen extends StatelessWidget {
  EventEditScreen(EventDetailProvider eventDetailProvider) {
    this.eventEditProvider = EventEditProvider(eventDetailProvider);
  }

  late final EventEditProvider eventEditProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: eventEditProvider,
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
                        controller: eventEditProvider.nameController,
                        title: eventEditProvider.event.name,
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
                          initialValue: eventEditProvider.event.startDate,
                          onSaved: eventEditProvider.setDataInicio,
                        ),
                        SizedBox(width: 12),
                        Icon(CupertinoIcons.arrow_right,
                            size: 30,
                            color: CupertinoColors.systemGrey3
                                .resolveFrom(context)),
                        SizedBox(width: 12),
                        FormItemDatePicker(
                          title: "data de fim",
                          initialValue: eventEditProvider.event.endDate,
                          onSaved: eventEditProvider.setDataFim,
                        ),
                      ]),
                      SizedBox(height: 12),
                      SizedBox(
                          height: 250,
                          child: EventDetailMap(
                              color: eventEditProvider.event.color1,
                              endereco: eventEditProvider.event.endereco)),
                      SizedBox(height: 12),
                      FormItemGroupTitle(title: "5 CONVIDADOS"),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                         borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Expanded(
                          child: Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Participante $index'),
                                  );
                                },),
                              CupertinoButton(child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: CupertinoDynamicColor.resolve(
                                        CupertinoColors.label, context),
                                    size: 30,
                                  ), 
                                   SizedBox(width: 12),
                                  Text(
                                    "adicionar participante",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoDynamicColor.resolve(
                                        CupertinoColors.label, context),
                                    ),
                                  ),
                                  SizedBox(width: 40),
                                  Icon(
                                    CupertinoIcons.bars,
                                     color: CupertinoDynamicColor.resolve(
                                        CupertinoColors.label, context),

                                  )
                                ],
                              ), onPressed:() {
                                ModalPopup(
                                  context: context, 
                                  title: "adicionar participante:", 
                                   height: 260,
                                   padding: EdgeInsets.only(top: 16),
                                   child: SizedBox(height: 26,
                                   )
                                   );
                              },), 
                            ],
                          ),
                        ),
                      ),
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
                                    eventEditProvider.delete(context);
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
