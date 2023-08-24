import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';

class EventoDetailScreen extends StatefulWidget {
  EventoDetailScreen({required this.id}) {
    evento = EventoListProvider.shared.evento(id);
  }

  final int id;
  late Evento evento;

  @override
  State<EventoDetailScreen> createState() => _EventoDetailScreenState();
}

class _EventoDetailScreenState extends State<EventoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: false,
              delegate: EventoDetailHeaderDelegate(evento: widget.evento)),
        ],
      ),
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
  double get maxExtent => 300.0;

  @override
  double get minExtent => 300.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class EventDetailHeader extends StatelessWidget {
  const EventDetailHeader({
    super.key,
    required this.evento,
  });

  final Evento evento;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(),
      child: SizedBox(
          child: Container(
            child: GradientWidget(
                color1: evento.randomColor1,
                color2: evento.randomColor2,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chevron_back,
                                  color: CupertinoColors.white,
                                  size: 30,
                                ),
                                Text(
                                  "eventos",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.white,
                                      letterSpacing: -1.8),
                                ),
                              ],
                            ),
                            Spacer(),
                            // Text(
                            //   "-",
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     fontWeight: FontWeight.bold,
                            //     color: CupertinoColors.white,
                            //   ),
                            // )
                            Icon(
                              CupertinoIcons.pencil,
                              color: CupertinoColors.white,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                evento.name,
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.white,
                                    letterSpacing: -1.8),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          // Spacer(),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              evento.randomEmoji,
                              style: TextStyle(
                                  fontSize: 72, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      ContainerText(text: "24 de Agosto, 22:00 — 05:00"),
                    ],
                  ),
                )),
          ),
          height: 300),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
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
