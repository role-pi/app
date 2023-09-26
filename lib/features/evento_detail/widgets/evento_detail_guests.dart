import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:role/models/usuario.dart';

class EventDetailGuests extends StatelessWidget {
  List<Usuario> convidados;

  EventDetailGuests({Key? key, required this.convidados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6.resolveFrom(context),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
            child: Text(
              "${convidados.length} convidados",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: -1.2),
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 110,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: convidados.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
                          color: const Color.fromARGB(255, 100, 101, 102),
                        ),
                      ),
                      SizedBox(height: 6),
                      AutoSizeText(
                        convidados[index].displayName,
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.systemGrey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
