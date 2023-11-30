import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/edit_transaction/providers/edit_transaction_provider.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/widgets/form/form_item_date_picker.dart';
import 'package:role/shared/widgets/select_user_modal.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/round_button.dart';

class EditTransactionScreen extends StatelessWidget {
  EditTransactionScreen(
      ItemDetailProvider itemDetailProvider, Transaction transaction) {
    this.provider = EditTransactionProvider(itemDetailProvider, transaction);
  }

  late final EditTransactionProvider provider;

  void show(BuildContext context) {
    ModalPopup(
            context: context, title: "editar transação", child: build(context))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<EditTransactionProvider>(builder: (context, value, child) {
              return ElasticButton(
                onPressed: () {
                  SelectUserModalPopup(
                          context: context,
                          onSelected: provider.selectUser,
                          user: UserLoginProvider.shared.user!,
                          users: provider.event.users!)
                      .show();
                },
                child: SelectUserPreviewButton(user: value.transaction.user),
              );
            }),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FormItemTextField(
                    controller: provider.valueController,
                    title: "valor",
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(width: 12),
                FormItemDatePicker(
                  initialValue: provider.transaction.date,
                  title: "data",
                  onSaved: provider.dateChanged,
                  nullable: false,
                ),
              ],
            ),
            SizedBox(height: 12),
            RoundButton(
              text: "atualizar",
              onPressed: () {
                provider.update(context);
              },
              textColor: CupertinoColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
