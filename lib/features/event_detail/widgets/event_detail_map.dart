import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:role/models/location.dart';

class EventDetailMap extends StatelessWidget {
  Color color;
  Location endereco;

  EventDetailMap({required this.color, required this.endereco});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EventoStyledMap(
            color: color,
            endereco: endereco,
            interactiveFlags: 0,
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: CupertinoDynamicColor.resolve(
                      CupertinoColors.systemGrey5, context)
                  .withOpacity(0.7),
            ),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(endereco.descricao,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.6,
                              color: CupertinoDynamicColor.resolve(
                                      CupertinoColors.label, context)
                                  .withAlpha(200))),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_right,
                          size: 24,
                          color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.label, context)
                              .withAlpha(200))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EventoStyledMap extends StatelessWidget {
  const EventoStyledMap(
      {super.key,
      required this.color,
      required this.endereco,
      this.interactiveFlags = InteractiveFlag.all & ~InteractiveFlag.rotate});

  final Color color;
  final Location endereco;
  final int interactiveFlags;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: color,
        ),
      ),
      Opacity(
        opacity: 0.97,
        child: FlutterMap(
          options: MapOptions(
            center: endereco.coordenadas,
            zoom: 15.0,
            interactiveFlags: interactiveFlags,
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
                  point: endereco.coordenadas,
                  width: 64,
                  height: 64,
                  builder: (context) => Icon(
                    CupertinoIcons.circle_fill,
                    color: CupertinoColors.black,
                    size: 64,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      IgnorePointer(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CupertinoDynamicColor.resolve(
                    CupertinoColors.label, context),
                backgroundBlendMode: BlendMode.exclusion,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: color,
                backgroundBlendMode: BlendMode.softLight,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
