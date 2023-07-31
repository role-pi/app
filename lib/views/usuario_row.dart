import 'package:flutter/cupertino.dart';
import 'package:role/models/usuario.dart';

class UsuarioRow extends StatelessWidget {
  final Usuario usuario;
  final Function()? onTap;

  const UsuarioRow({required this.usuario, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(usuario.displayName),
        ],
      ),
    );
  }
}
