import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/split_costs/providers/split_costs_provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/shared/utils/utils.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class SplitCostsScreen extends StatelessWidget {
  late SplitCostsProvider provider;

  SplitCostsScreen(List<SplitCostTransaction> transactions) {
    this.provider = SplitCostsProvider(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomNavigationBar(
                leadingText: "voltar",
                onPressedLeading: () => Navigator.pop(context),
                title: "distribuição de gastos",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.builder(
                  itemCount: provider.transactions.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    SplitCostTransaction transaction =
                        provider.transactions[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color:
                              CupertinoColors.systemGrey6.resolveFrom(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RemoteProfilePicture(
                                  url: transaction.fromUser.profilePhoto,
                                  size: 38,
                                ),
                                SizedBox(width: 8),
                                AutoSizeText(transaction.fromUser.displayName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(width: 8),
                                Icon(CupertinoIcons.arrow_right,
                                    color: CupertinoColors.secondaryLabel
                                        .resolveFrom(context)),
                                SizedBox(width: 8),
                                RemoteProfilePicture(
                                  url: transaction.toUser.profilePhoto,
                                  size: 38,
                                ),
                                SizedBox(width: 8),
                                AutoSizeText(transaction.toUser.displayName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            SizedBox(height: 12),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Text(
                                      formatCurrency(transaction.amount),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -1.2),
                                    ),
                                    Spacer(),
                                    transaction.toUser.pixKey != null
                                        ? ElasticButton(
                                            onPressed: () =>
                                                provider.showPixScreen(
                                                    context, transaction),
                                            child: Icon(CupertinoIcons.qrcode,
                                                size: 32,
                                                color: CupertinoColors
                                                    .secondaryLabel
                                                    .resolveFrom(context)),
                                          )
                                        : SizedBox(),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
