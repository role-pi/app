import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:role/shared/widgets/custom_toast.dart';
import 'package:role/shared/widgets/round_button.dart';

class QrCodeWidget extends StatelessWidget {
  final String chavePix;

  QrCodeWidget(this.chavePix);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          size: Size(100, 100),
          painter: QrPainter(
            data: chavePix,
            version: QrVersions.auto,
            gapless: false,
          ),
        ),
        Text(
          "Chave Pix: $chavePix",
          style: TextStyle(fontSize: 16),
        ),
        RoundButton(
          text: "Copiar",
          onPressed: () {
            Clipboard.setData(ClipboardData(text: chavePix));
            final toast = CustomToast(
              title: "Chave copiada com sucesso",
              icon: CupertinoIcons.check_mark,
              color: CupertinoColors.systemGreen,
            );

            FToast fToast = FToast();
            fToast.init(context);
            fToast.showToast(
              child: toast,
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 2),
            );
          },
        ),
      ],
    );
  }
}
