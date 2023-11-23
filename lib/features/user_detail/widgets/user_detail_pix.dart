import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/modal_popup.dart';

class NewPixKeyScreen extends StatelessWidget{
  NewPixKeyScreen(UserDetailProvider userDetailProvider){
    this.provider = pixKeyController(userDetailProvider);
  }
  late final pixKeyController provider;

  void show(BuildContext context) {
    ModalPopup(
            context: context, title: "adicionar chave pix", child: build(context))
        .show();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Padding(padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Consumer<UserDetailProvider>(
                  builder: (context, value, child) {
                  return FormItemTextField(
                   controller: provider.pixKeyController,
                   title: "chave pix",
                    padding: EdgeInsets.all(4.0),
                   enabled: !value.loading,
                   textSize: 16.0,
                  );
                },
               ),
              ),
              SizedBox(width: 12),
              Text(
                   "Você pode informar uma chave Pix para receber pagamentos ao dividir os gastos de um evento. \n\nA chave pode ser CPF, e-mail, telefone ou aleatória, e a validação ocorrerá somente no aplicativo do banco no momento do pagamento.",
                    style: TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context)),
               ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}