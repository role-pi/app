import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:role/models/event.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class EventItemRowGuests extends StatelessWidget {
  EventItemRowGuests({required this.event});

  final Event event;
  final showMax = 3;
  final double size = 42;

  List<Widget> makeWidgets() {
    List<Widget> list = [];
    int count = 0;

    List<User> users = [
      User(
          id: 0,
          email: "",
          profilePhoto:
              "https://pbs.twimg.com/profile_images/1699634404291661824/Zc2OT-q4_400x400.jpg"),
      User(
          id: 0,
          email: "",
          profilePhoto:
              "https://pbs.twimg.com/profile_images/1699634404291661824/Zc2OT-q4_400x400.jpg"),
      User(
          id: 0,
          email: "",
          profilePhoto:
              "https://pbs.twimg.com/profile_images/1699634404291661824/Zc2OT-q4_400x400.jpg")
    ];

    int total = min(showMax, users.length);
    bool showMore = users.length > showMax;

    for (var user in users) {
      if (count >= total) {
        break;
      }

      var picture = RemoteProfilePicture(
        url: user.profilePhoto,
        size: size,
        colorBlendMode: BlendMode.luminosity,
      );

      var offset = Offset(3.0 * (total - count - 1), 0.0);

      if (count == showMax - 1 && showMore) {
        list.add(SizedBox(
          width: size * 40 / 42,
          height: size,
          child: ClipPath(
            clipper: UserListClipPath(),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  backgroundBlendMode: BlendMode.luminosity),
            ),
          ),
        ));
      } else if (count == 0) {
        list.add(Transform.translate(
          offset: offset,
          child: picture,
        ));
      } else {
        list.add(
          Transform.translate(
            offset: offset,
            child: ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: UserListClipPath(),
              child: picture,
            ),
          ),
        );
      }

      count++;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Row(
        children: makeWidgets(),
      ),
    );
  }
}

class UserListClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path = Path();
    path.lineTo(size.width * 0.43, 0);
    path.cubicTo(size.width * 0.75, 0, size.width, size.height * 0.22,
        size.width, size.height / 2);
    path.cubicTo(size.width, size.height * 0.78, size.width * 0.75, size.height,
        size.width * 0.43, size.height);
    path.cubicTo(size.width * 0.26, size.height, size.width * 0.1,
        size.height * 0.93, 0, size.height * 0.82);
    path.cubicTo(size.width * 0.07, size.height * 0.73, size.width * 0.12,
        size.height * 0.62, size.width * 0.12, size.height / 2);
    path.cubicTo(size.width * 0.12, size.height * 0.38, size.width * 0.07,
        size.height * 0.27, 0, size.height * 0.18);
    path.cubicTo(size.width * 0.1, size.height * 0.07, size.width * 0.26, 0,
        size.width * 0.43, 0);
    path.cubicTo(
        size.width * 0.43, 0, size.width * 0.43, 0, size.width * 0.43, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
