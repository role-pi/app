import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventoDetailScreen extends StatelessWidget {
  final Evento evento;

  EventoDetailScreen({required this.evento});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            delegate: EventoDetailHeaderDelegate(evento: evento),
          ),
        ],
      ),
    );
  }
}

class EventoDetailHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Evento evento;

  EventoDetailHeaderDelegate({required this.evento});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
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
  final Evento evento;

  EventDetailHeader({required this.evento});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            Container(
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
                            Text(
                              "< eventos",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                                letterSpacing: -1.8,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "-",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            evento.name,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.white,
                              letterSpacing: -1.8,
                            ),
                          ),
                          Spacer(),
                          Text(
                            evento.randomEmoji,
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ContainerText(text: "24 de Agosto, 22:00 — 05:00"),
                    ],
                  ),
                ),
              ),
              height: 300,
            ),
            Positioned.fill(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(evento.latitude, evento.longitude),
                  zoom: 15.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 45.0,
                        height: 45.0,
                        point: LatLng(evento.latitude, evento.longitude),
                        builder: (ctx) => Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _CustomClipper _CustomClipper() => _CustomClipper();

  TileLayerOptions(
      {required String urlTemplate, required List<String> subdomains}) {}

  MarkerLayerOptions({required List<Marker> markers}) {}
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cornerRadius = 12.0;

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

class GradientWidget extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Widget child;

  GradientWidget({
    required this.color1,
    required this.color2,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}

class Evento {
  final String name;
  final Color randomColor1;
  final Color randomColor2;
  final String randomEmoji;
  final double latitude;
  final double longitude;

  Evento({
    required this.name,
    required this.randomColor1,
    required this.randomColor2,
    required this.randomEmoji,
    required this.latitude,
    required this.longitude,
  });
}

class ContainerText extends StatelessWidget {
  final String text;

  ContainerText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

void main() {
  runApp(
    CupertinoApp(
      home: EventoDetailScreen(
        evento: Evento(
          name: "Nome do Evento",
          randomColor1: Colors.blue,
          randomColor2: Colors.green,
          randomEmoji: "🎉",
          latitude: -23.550520,
          longitude: -46.633308,
        ),
      ),
    ),
  );
}
