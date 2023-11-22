import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class ItemDetailTransactionRow extends StatelessWidget {
  const ItemDetailTransactionRow({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RemoteProfilePicture(
          url: transaction.user.profilePhoto,
          size: 42,
        ),
        SizedBox(width: 12),
        Expanded(
          child: AutoSizeText(transaction.user.displayName,
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
              "R\$ ${(transaction.amount ?? 0).toStringAsFixed(2).replaceAll(".", ",")}",
          size: 18,
        )
      ],
    );
  }
}
