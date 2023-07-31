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
        color: CupertinoColors.systemGrey6,
        padding: EdgeInsets.all(8),
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
