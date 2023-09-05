import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventoDetailMap extends StatelessWidget {
  Color color;

  EventoDetailMap({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          Opacity(
            opacity: 0.97,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-26.905926949896116, -49.07710147997988),
                zoom: 15.0,
                interactiveFlags: 0,
              ),
              nonRotatedChildren: [],
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tiles.stadiamaps.com/tiles/stamen_toner_lite/{z}/{x}/{y}{r}.png',
                  userAgentPackageName: 'com.joogps.role',
                  // retinaMode: true,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(-26.905926949896116, -49.07710147997988),
                      width: 64,
                      height: 64,
                      builder: (context) => Icon(
                        CupertinoIcons.circle_fill,
                        color: color,
                        size: 64,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: color,
              backgroundBlendMode: BlendMode.softLight,
            ),
          ),
        ]),
      ),
    );
  }
}
