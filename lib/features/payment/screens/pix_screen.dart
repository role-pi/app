import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/features/payment/widgets/qr_code.dart';
import 'package:role/shared/widgets/blur_overlay.dart';

class PixPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Pagamento Pix"),
      ),
      child: Center(
        child: Container(
            width: 150, 
            height: 300, 
            color: Colors.white,
            child: Column(
              children: [Text(
                "Chave Pix",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            QrCodeWidget("1116d532-b72b-4c9b-bd52-2f1c2112cdda"),
              ]
            ),
          ),
      ),
    );
  }
}
