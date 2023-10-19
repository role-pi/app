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
              Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                     
                      child: Center(
                        child: Icon(
                          CupertinoIcons.bubble_left_fill,
                          color: CupertinoColors.secondaryLabel.resolveFrom(context),
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insumos[index].nome,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
                  ),
                  Text(
                    "há 2 horas",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12),
               Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 136, 136, 141), 
                  borderRadius: BorderRadius.circular(4.0), 
                ),
                padding: EdgeInsets.all(8.0), 
                child: Text(
                  insumos[index].valor.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                    color: CupertinoColors
                        .white, 
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
