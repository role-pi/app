import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_event_provider.dart';
import 'package:role/shared/widgets/big_form_text_field.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewEventName extends StatefulWidget {
  @override
  _NewEventNameState createState() => _NewEventNameState();
}

class _NewEventNameState extends State<NewEventName> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    NewEventProvider provider =
        Provider.of<NewEventProvider>(context, listen: false);

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
                ),
              )
            ],
          ),
          SizedBox(height: 24.0),
          BigFormTextField(
            controller: provider.nameController,
            color: CupertinoColors.label.resolveFrom(context).withOpacity(0.6),
            onFieldSubmitted: (_) => provider.setName(context),
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundButton(
              text: "continuar",
              onPressed: () => provider.setName(context),
              // onPressed: onSubmit,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
