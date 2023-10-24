import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class EventDetailGuests extends StatelessWidget {
  final List<User> convidados;

  EventDetailGuests({Key? key, required this.convidados}) : super(key: key);

  String get title {
    if (convidados.length == 1) {
      return "1 convidado";
    } else {
      return "${convidados.length} convidados";
    }
  }

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
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: -1.5),
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: convidados.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      RemoteProfilePicture(
                        url: convidados[index].profilePhoto,
                        size: 72,
                      ),
                      SizedBox(height: 6),
                      AutoSizeText(
                        convidados[index].displayName,
                        style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                            fontWeight: FontWeight.w500),
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
