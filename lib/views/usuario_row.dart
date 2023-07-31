import 'package:flutter/cupertino.dart';
import 'package:role/models/usuario.dart';

class UsuarioRow extends StatelessWidget {
  final Usuario usuario;
  final Function()? onTap;

  const UsuarioRow({required this.usuario, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: RadialGradient(
            colors: [CupertinoColors.systemPink, CupertinoColors.systemGrey6],
            stops: [0.2, 1.0],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(usuario.displayName),
          ],
        ),
      ),
    );
  }
}
