import 'package:flutter/cupertino.dart';
import 'package:map_location_picker/map_location_picker.dart';

class EventMapScreen extends StatelessWidget {
  final Color color;

  EventMapScreen({required this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: MapLocationPicker(
      apiKey: "AIzaSyDlL4sUMUqmLeFOvQiqs3JtQ7kppZtha14",
      onNext: (GeocodingResult? result) {},
    ));
  }
}
