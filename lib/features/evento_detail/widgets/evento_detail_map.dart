import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventoDetailMap extends StatelessWidget {
  Color color;

  EventoDetailMap({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(-26.905926949896116, -49.07710147997988),
                zoom: 17.0,
                interactiveFlags: 0,
              ),
              nonRotatedChildren: [],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.joogps.role',
                  retinaMode: true,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: color,
                backgroundBlendMode: BlendMode.softLight,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
