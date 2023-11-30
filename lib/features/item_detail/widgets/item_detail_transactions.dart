import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/edit_transaction/screens/edit_transaction_screen.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/features/item_detail/widgets/item_detail_transaction_row.dart';
import 'package:role/features/new_transaction/screens/new_transaction_screen.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/utils/utils.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class ItemDetailTransactions extends StatelessWidget {
  ItemDetailTransactions(ItemDetailProvider itemDetailProvider)
      : provider = itemDetailProvider;

  late final ItemDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "PAGO POR",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context)),
            ),
            Spacer(),
            ElasticButton(
              onPressed: () {
                NewTransactionScreen(provider).show(context);
              },
              child: Icon(Icons.add,
                  color: CupertinoColors.label.resolveFrom(context), size: 28),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Consumer<ItemDetailProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.item.transactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = value.item.transactions[index];
                return ElasticButton(
                  onPressed: () {
                    EditTransactionScreen(provider, transaction).show(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ItemDetailTransactionRow(transaction: transaction),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: 8),
        Divider(),
        SizedBox(height: 8),
        Row(
          children: [
            Text("Total".toUpperCase(),
                style: TextStyle(
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.0,
                    fontSize: 16.0)),
            Spacer(),
            Consumer<ItemDetailProvider>(
              builder: (context, value, child) {
                return Text(formatCurrency(value.item.amount),
                    style: TextStyle(
                        color: CupertinoColors.secondaryLabel,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1.0,
                        fontSize: 16.0));
              },
            )
          ],
        )
      ],
    );
  }
}
