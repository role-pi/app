import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/features/new_transaction/providers/new_transaction_provider.dart';
import 'package:role/features/new_transaction/screens/new_transaction_select_user_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewTransactionScreen extends StatelessWidget {
  NewTransactionScreen(ItemDetailProvider itemDetailProvider) {
    this.provider = NewTransactionProvider(itemDetailProvider);
  }

  late final NewTransactionProvider provider;

  void show(BuildContext context) {
    ModalPopup(
            context: context,
            title: "adicionar transação",
            child: build(context))
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
            Consumer<NewTransactionProvider>(builder: (context, value, child) {
              return ElasticButton(
                onPressed: () {
                  NewTransactionSelectUserModalPopup(
                          context: context,
                          onSelected: provider.selectUser,
                          user: UserLoginProvider.shared.user!,
                          users: provider.event.users!)
                      .show();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6.resolveFrom(context),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 13),
                  child: Row(
                    children: [
                      Consumer<UserLoginProvider>(
                          builder: (context, provider, child) {
                        return RemoteProfilePicture(
                            url: value.transaction.user.profilePhoto, size: 58);
                      }),
                      SizedBox(width: 12),
                      Text(
                        value.transaction.user.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.5,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 12),
            FormItemTextField(
              controller: provider.valueController,
              title: "valor",
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 12),
            RoundButton(
              text: "adicionar",
              onPressed: () {
                provider.addTransaction(context);
              },
              textColor: CupertinoColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
