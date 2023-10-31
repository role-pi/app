import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:role/shared/widgets/custom_toast.dart';
import 'package:role/shared/widgets/round_button.dart';
import 'package:pix_flutter/pix_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String chavePix;

  QrCodeWidget(this.chavePix);
   PixFlutter pixFlutter = PixFlutter(
                  payload: Payload(
                      pixKey: 'gregiorogerio@yahoo.com.br',
                      description: 'DESCRIÇÃO_DA_COMPRA',
                      merchantName: 'MERCHANT_NAME',
                      merchantCity: 'CITY_NAME',
                      txid: 'TXID', // Até 25 caracteres para o QR Code estático
                      amount: '0.1'));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Chave Pix: $chavePix",
            style: TextStyle(fontSize: 16),
          ),
          RoundButton(
            text: "Copiar",
            onPressed: () {
             
         
             
              // Clipboard.setData(ClipboardData(text: chavePix));
              // final toast = CustomToast(
              //   title: "Chave copiada com sucesso",
              //   icon: CupertinoIcons.check_mark,
              //   color: CupertinoColors.systemGreen,
              // );

              // FToast fToast = FToast();
              // fToast.init(context);
              // fToast.showToast(
              //   child: toast,
              //   gravity: ToastGravity.BOTTOM,
              //   toastDuration: Duration(seconds: 2),
              // );
            },
          ),
          SizedBox(height: 20,),
           CustomPaint(
                size: Size(100, 100),
                painter: QrPainter(
                  data: pixFlutter.getQRCode(),
                  version: QrVersions.auto,
                  gapless: false,
                ),
              ),
        ],
      ),
    );
  }
}
