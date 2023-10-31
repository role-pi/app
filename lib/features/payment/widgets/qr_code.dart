import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String chavePix;

  QrCodeWidget(this.chavePix);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          size: Size(200, 200), 
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
        CupertinoButton(
          child: Text("Copiar"),
          color: Colors.black,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: chavePix));
           FToast fToast = FToast();
            fToast.init(context);
            fToast.showToast(
              child: Text("Chave copiada"),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 2),
            );
          },
        ),
      ],
    );
  }
}
