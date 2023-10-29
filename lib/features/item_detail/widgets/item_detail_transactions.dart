import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class ItemDetailTransactions extends StatelessWidget {
  final List<Transaction> transactions;

  ItemDetailTransactions({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = transactions[index];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RemoteProfilePicture(
              url: transaction.userProfilePicture,
              size: 48,
            ),
            SizedBox(width: 12),
            Expanded(
              child: AutoSizeText(transaction.userName,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: -1.1,
                  )),
            ),
            SizedBox(width: 12),
            ContainerText(
              text:
                  "R\$ ${transaction.valor.toStringAsFixed(2).replaceAll(".", ",")}",
              size: 18,
            )
          ],
        );
      },
    );
  }
}
