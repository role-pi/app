import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class QrCodeWidget extends StatelessWidget {
  final String chavePix;

  QrCodeWidget(this.chavePix);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImage(
          data: chavePix,
          version: QrVersions.auto,
          size: 200,
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
            // Adicione feedback ao usuário, por exemplo, um snackbar
          },
        ),
      ],
    );
  }
}
