import 'package:flutter/cupertino.dart';

class EventDetailGuests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> guestList = [
      "Convidado 1",
      "Convidado 2",
      "Convidado 3",
      "Convidado 4",
      "Convidado 5",
      "Convidado 5",
      "Convidado 5",
    ];

    return Container(
        decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 212, 212),
        borderRadius: BorderRadius.circular(12.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          
          children: [
            Text("5 convidados",
            style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 26,),
            
            ),
          
            SizedBox(
              height: 100,
              child: ListView.builder(
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
                            child: Image.asset("assets/Star.png"),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          guestList[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
