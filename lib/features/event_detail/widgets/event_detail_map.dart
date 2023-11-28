import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:role/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailMap extends StatelessWidget {
  final Color color;
  final Location location;

  EventDetailMap({required this.color, required this.location});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EventStyledMap(
            color: color,
            location: location,
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
                      Expanded(
                        child: Text(location.descricao,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.6,
                                color: CupertinoDynamicColor.resolve(
                                        CupertinoColors.label, context)
                                    .withAlpha(200))),
                      ),
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

class EventStyledMap extends StatelessWidget {
  EventStyledMap({super.key, required this.color, required this.location});

  final Color color;
  final Location location;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String get mapStyle => """
    [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
  """;

  String get darkMapStyle => """
    [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#333333"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#1a1a1a"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "all",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#333333"
      }
    ]
  },
  {
    "featureType": "all",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  }
]
  """;

  CameraPosition get _kGooglePlex => CameraPosition(
        target: location.latLng,
        zoom: 16,
      );

  @override
  Widget build(BuildContext context) {
    String style = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? darkMapStyle
        : mapStyle;

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      scrollGesturesEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        controller.setMapStyle(style);
      },
    );
  }
}
