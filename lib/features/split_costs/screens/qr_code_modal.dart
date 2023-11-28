import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:role/features/split_costs/providers/split_costs_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:pix_flutter/pix_flutter.dart';

class QRCodeModalPopup extends StatelessWidget {
  late final SplitCostTransaction transaction;
  late final SplitCostsProvider provider;

  QRCodeModalPopup(this.transaction, this.provider);

  PixFlutter get qrPixKey => PixFlutter(
      payload: Payload(
          pixKey: transaction.toUser.pixKey ?? 'PIX_KEY',
          description: "Distribuição de gastos",
          merchantName: 'rolê',
          merchantCity: 'Gaspar',
          txid: 'TXID',
          amount: transaction.amount.toStringAsFixed(2)));

  String get pixKey => transaction.toUser.pixKey ?? 'PIX_KEY';

  void show(BuildContext context) {
    ModalPopup(context: context, title: "pagar com pix", child: build(context))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 22.0;
    const double qrCodePadding = 84.0;

    double qrCodeSize =
        MediaQuery.of(context).size.width - padding * 2 - qrCodePadding * 2;

    return Padding(
      padding: const EdgeInsets.fromLTRB(padding, 4.0, padding, padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormItemGroupTitle(title: "Chave pessoal"),
          ElasticButton(
              child: Container(
                decoration: BoxDecoration(
                    color: CupertinoColors.systemGroupedBackground
                        .resolveFrom(context),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RemoteProfilePicture(
                                  url: transaction.toUser.profilePhoto,
                                  size: 28),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                transaction.toUser.displayName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    letterSpacing: -1.2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            pixKey,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.secondaryLabel
                                    .resolveFrom(context)),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.doc_on_clipboard,
                        size: 32,
                        color:
                            CupertinoColors.secondaryLabel.resolveFrom(context),
                      )
                    ],
                  ),
                ),
              ),
              onPressed: () => provider.copyKey(context, pixKey)),
          SizedBox(
            height: 16,
          ),
          FormItemGroupTitle(title: "Copia e cola"),
          ElasticButton(
            onPressed: () => provider.copyKey(context, pixKey),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Column(
                children: [
                  Container(
                    color: CupertinoColors.systemGroupedBackground
                        .resolveFrom(context)
                        .withOpacity(0.5),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: CustomPaint(
                          size: Size(qrCodeSize, qrCodeSize),
                          painter: QrPainter(
                            data: qrPixKey.getQRCode(),
                            version: QrVersions.auto,
                            gapless: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            qrPixKey.getQRCode(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.doc_on_clipboard,
                          size: 24,
                          color: CupertinoColors.secondaryLabel
                              .resolveFrom(context),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(24.0),
                    color: CupertinoColors.systemGroupedBackground
                        .resolveFrom(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
