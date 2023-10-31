import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/shared/widgets/blur_overlay.dart';

class PixPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Pagamento Pix"),
      ),
      child: Center(
        child: BlurOverlay(
          showing: true, 
          onDismiss: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 150, 
            height: 300, 
            color: Colors.white,
            child: Center(
              // Adicionar o widget de qr
              child: Text(
                "Chave Pix",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
