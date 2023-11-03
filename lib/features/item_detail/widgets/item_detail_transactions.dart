import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/features/item_detail/widgets/item_detail_transaction_row.dart';
import 'package:role/features/new_transaction/screens/new_transaction_screen.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class ItemDetailTransactions extends StatelessWidget {
  ItemDetailTransactions({Key? key}) : super(key: key);

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
                NewTransactionScreen().show(context);
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
                return ItemDetailTransactionRow(transaction: transaction);
              },
            );
          },
        )
      ],
    );
  }
}
