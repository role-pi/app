import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:role/features/event_edit/screens/evento_edit_screen.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class EventDetailHeader extends StatelessWidget {
  const EventDetailHeader({
    super.key,
    required this.evento,
  });

  final Evento evento;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _EventoDetailHeaderClipper(),
      child: SizedBox(
          child: Container(
              child: GradientWidget(
        color1: evento.color1,
        color2: evento.color2,
        child: Column(
          children: [
            Opacity(
                opacity: 0.6,
                child: CustomNavigationBar(
                    leadingText: "eventos",
                    trailingIcon: CupertinoIcons.pencil,
                    onPressedLeading: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTrailing: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return EventoEditScreen(id: evento.id);
                      }));
                    })),
            Spacer(),
            Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                evento.name,
                                style: TextStyle(
                                    fontSize: 52,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -2.4,
                                    height: 1.0),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(width: 28),
                            evento.emoji.isNotEmpty
                                ? SizedBox(
                                    // fit: BoxFit.fitWidth,
                                    width: 72,
                                    child: Text(
                                      evento.emoji,
                                      style: TextStyle(
                                          fontSize: 72,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      ContainerText(text: evento.dateDescription),
                    ]))
          ],
        ),
      ))),
    );
  }
}

class EventoDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  EventoDetailHeaderDelegate({required this.evento});

  final Evento evento;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return EventDetailHeader(evento: evento);
  }

  @override
  double get minExtent => 300.0;

  @override
  double get maxExtent => 320.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _EventoDetailHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cornerRadius = 12.0; // Adjust this value for the corner radius

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cornerRadius);
    path.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
    );
    path.lineTo(cornerRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - cornerRadius),
      radius: Radius.circular(cornerRadius),
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
