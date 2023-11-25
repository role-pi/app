import 'package:flutter/cupertino.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailPixKeyModal extends StatelessWidget {
  late final UserDetailProvider provider;

  UserDetailPixKeyModal({required this.provider}) {}

  void show(BuildContext context) {
    ModalPopup(context: context, title: "chave pix", child: build(context))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              FormItemTextField(
                controller: provider.pixKeyController,
                title: "chave pix",
                padding: EdgeInsets.all(4.0),
                enabled: !provider.loading,
                textSize: 16.0,
              ),
              SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Você pode informar uma chave Pix para receber pagamentos ao dividir os gastos de um evento. \n\nA chave pode ser CPF, e-mail, telefone ou aleatória, e a validação ocorrerá somente no aplicativo do banco no momento do pagamento.",
                  style: TextStyle(
                      fontSize: 13,
                      color:
                          CupertinoColors.secondaryLabel.resolveFrom(context)),
                ),
              ),
              RoundButton(
                onPressed: () async {
                  provider.updatePixKey(context);
                },
                rectangleColor: CupertinoColors.activeBlue,
                textColor: CupertinoColors.white,
                text: "salvar",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
