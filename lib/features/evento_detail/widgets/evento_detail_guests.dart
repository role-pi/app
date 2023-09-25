import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class EventDetailGuests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> guestList = ["Você", "Maiara", "Ana", "Caio", "Rafael"];

    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        // backgroundBlendMode: BlendMode.luminosity,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
            child: Text(
              "5 convidados",
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
              itemCount: guestList.length,
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
                        guestList[index],
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
