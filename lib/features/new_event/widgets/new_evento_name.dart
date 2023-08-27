import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/shared/widgets/big_form_text_field.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewEventoName extends StatefulWidget {
  @override
  _NewEventoNameState createState() => _NewEventoNameState();
}

class _NewEventoNameState extends State<NewEventoName> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NewEventoProvider _newEventoProvider =
        Provider.of<NewEventoProvider>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              Text(
                "novo evento",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                  color: CupertinoColors.black.withOpacity(0.8),
                ),
              )
            ],
          ),
          SizedBox(height: 24.0),
          BigFormTextField(
            controller: _nameController,
            color: CupertinoColors.black.withOpacity(0.5),
            onChanged: (value) {
              // setState(() {
              //   enabled = !value?.isEmpty ?? false;
              // });
            },
            onFieldSubmitted: (_) {
              // onSubmit();
            },
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundButton(
              text: "continuar",
              rectangleColor: CupertinoColors.black.withOpacity(0.8),
              onPressed: () {
                _newEventoProvider.setName(_nameController.text);
              },
              // onPressed: onSubmit,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
