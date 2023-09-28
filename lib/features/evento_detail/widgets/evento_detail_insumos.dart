import 'package:flutter/cupertino.dart';
import 'package:role/models/insumo.dart';

class EventoDetailInsumos extends StatelessWidget {
  List<Insumo> insumos;

  EventoDetailInsumos({Key? key, required this.insumos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: insumos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey6, context),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16.0),
            child: Row(children: [
              Text(
                insumos[index].nome,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                ),
              ),
              SizedBox(width: 12),
              Text(
                insumos[index].descricao,
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: -1.0,
                ),
              ),
              Spacer(),
              Text(
                insumos[index].valor.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
