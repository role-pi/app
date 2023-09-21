import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:role/features/evento_detail/widgets/evento_detail_map.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventoEditScreen extends StatefulWidget {
  EventoEditScreen({required this.id}) {
    evento = EventoListProvider.shared.evento(id);
  }

  final int id;
  late Evento evento;

  @override
  State<EventoEditScreen> createState() => _EventoEditScreenState();
}

class _EventoEditScreenState extends State<EventoEditScreen> {
  TextEditingController textController = TextEditingController();

  DateTime dateTime1 = DateTime(2016, 8, 3, 17, 45);
  DateTime dateTime2 = DateTime(2016, 8, 3, 17, 45);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SingleChildScrollView(
      child: Column(children: [
        CustomNavigationBar(
            trailingText: "salvar",
            onPressedLeading: () {
              Navigator.of(context).pop();
            },
            onPressedTrailing: () {},
            accentColor: widget.evento.color1),
        Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Column(
              children: [
                FormItemGroupTitle(title: "INFORMAÇÕES"),
                FormItemTextField(
                    controller: textController, title: widget.evento.name),
                SizedBox(height: 12),
                Row(children: [
                  FormItemDatePicker(
                      dateTime: dateTime1,
                      onDateTimeChanged: (d) {
                        setState(() {
                          dateTime1 = d;
                        });
                      }),
                  SizedBox(width: 12),
                  Icon(CupertinoIcons.arrow_right,
                      size: 30,
                      color: CupertinoColors.systemGrey3.resolveFrom(context)),
                  SizedBox(width: 12),
                  FormItemDatePicker(
                      dateTime: dateTime2,
                      onDateTimeChanged: (d) {
                        setState(() {
                          dateTime2 = d;
                        });
                      }),
                ]),
                SizedBox(height: 12),
                SizedBox(
                    height: 250,
                    child: EventoDetailMap(
                        color: widget.evento.color1,
                        endereco: widget.evento.endereco)),
                SizedBox(height: 12),
                FormItemGroupTitle(title: "5 CONVIDADOS"),
                SizedBox(height: 12),
                RoundButton(
                  onPressed: () async {},
                  textColor: CupertinoColors.white,
                  rectangleColor: CupertinoColors.systemRed,
                  text: 'excluir evento',
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}

class FormItemDatePicker extends StatelessWidget {
  const FormItemDatePicker(
      {super.key, required this.dateTime, required this.onDateTimeChanged});

  final DateTime dateTime;
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
              '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute}',
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
                  "data de início",
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

class ButtonDate extends StatefulWidget {
  const ButtonDate({Key? key}) : super(key: key);

  @override
  State<ButtonDate> createState() => _ButtonDateState();
}

 class _ButtonDateState extends State<ButtonDate> {
  DateTime dateTimeRaf = DateTime(2016, 8, 3, 17, 45);

@override
Widget build(BuildContext context) {
  return CupertinoPageScaffold(
    child: Center(
      child: CupertinoButton(
        child: const Text('Cupertino Date Picker'),
        onPressed: (){
          showCupertinoModalPopup(context: context,
           builder: (BuildContext context) => SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              backgroundColor: Colors.white,
              initialDateTime: dateTimeRaf,
              onDateTimeChanged: (DateTime newTime){
                setState(() => dateTimeRaf = newTime);
              },
              use24hFormat: true,
              mode: CupertinoDatePickerMode.date,
            ),
           ),
           );
        },
      ),
      ),
   );
  }
}
 