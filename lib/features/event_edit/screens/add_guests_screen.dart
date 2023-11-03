import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class AddGuestsScreen extends StatelessWidget {
  AddGuestsScreen() {}

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Column(
      children: [
        CustomNavigationBar(
          topPadding: 0,
          leadingIcon: null,
          leadingText: "adicionar convidados",
          trailingText: "feito",
          textSize: 26,
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              FormItemTextField(title: "busque por um nome ou email"),
            ],
          ),
        ),
      ],
    ));
  }
}
