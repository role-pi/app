import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/features/event_list/widgets/evento_item_row.dart';
import 'package:role/models/evento.dart';
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
                      Spacer(),
                      Row(
                        children: [
                            Text(
                              evento.name,
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.white,
                                  letterSpacing: -1.8),
                            ),
                          Spacer()
                        ],
                      ),
                      ContainerText(text: "24 de Agosto"),
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
