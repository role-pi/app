import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/features/new_insumo/screens/new_insumo_screen.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';
import 'package:role/shared/widgets/navigation_bar.dart';

class EventoDetailScreen extends StatelessWidget {
  EventoDetailScreen({required this.id}) {
    evento = EventoListProvider.shared.evento(id);
  }

  final int id;
  late Evento evento;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: false,
              delegate: EventoDetailHeaderDelegate(evento: evento)),
          SliverToBoxAdapter(
              child: CupertinoButton(
                  child: Text("Adicionar insumo"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NewInsumoScreen(id: id)));
                    // Navigator.pushNamed(context, "/evento/1/insumo");
                  }))
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
            color1: evento.color1,
            color2: evento.color2,
            child: Column(
              children: [
                Opacity(
                  opacity: 0.6,
                  child: NavigationBar(
                    leadingText: "eventos",
                    trailingIcon: CupertinoIcons.pencil,
                    onPressedLeading: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTrailing: () {},
                  ),
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    evento.name,
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: CupertinoColors.black,
                                        letterSpacing: -1.8),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              evento.emoji.isNotEmpty
                                  ? FittedBox(
                                      fit: BoxFit.fitWidth,
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
                          ContainerText(text: "24 de Agosto, 22:00 — 05:00"),
                        ]))
              ],
            ),
          )),
          height: 300),
    );
  }
}

// Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CupertinoButton(
//           padding: EdgeInsets.zero,
//           child: Row(
//             children: [
//               Icon(
//                 CupertinoIcons.chevron_back,
//                 color: CupertinoColors.black,
//                 size: 30,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 5.0),
//                 child: Text(
//                   "eventos",
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: CupertinoColors.black,
//                       letterSpacing: -1.8),
//                 ),
//               ),
//             ],
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         Spacer(),
//         Icon(
//           CupertinoIcons.pencil,
//           color: CupertinoColors.black,
//           size: 38,
//         ),
//       ],
//     );
//   }

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
