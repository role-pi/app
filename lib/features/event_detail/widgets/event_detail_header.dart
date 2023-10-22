import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/screens/event_edit_screen.dart';
import 'package:role/features/event_detail/providers/evento_detail_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class EventDetailHeader extends StatelessWidget {
  const EventDetailHeader({
    super.key,
    required this.evento,
  });

  final Event evento;

  @override
  Widget build(BuildContext context) {
    EventDetailProvider _eventoDetailProvider =
        Provider.of<EventDetailProvider>(context, listen: false);

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
                        return EventEditScreen(_eventoDetailProvider);
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
                            Consumer<EventDetailProvider>(
                              builder: (context, provider, child) {
                                return Expanded(
                                  child: AutoSizeText(
                                    provider.evento.name,
                                    style: TextStyle(
                                        fontSize: 52,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -2.4,
                                        height: 1.0),
                                    maxLines: 2,
                                  ),
                                );
                              },
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
                      Consumer<EventDetailProvider>(
                        builder: (context, provider, child) {
                          return ContainerText(
                              text: provider.evento.dateDescription);
                        },
                      ),
                    ]))
          ],
        ),
      ))),
    );
  }
}

class EventoDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  EventoDetailHeaderDelegate({required this.evento});

  final Event evento;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return EventDetailHeader(evento: evento);
  }

  @override
  double get minExtent => 320.0;

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