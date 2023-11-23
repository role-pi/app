import 'package:flutter/cupertino.dart';
import 'package:map_location_picker/map_location_picker.dart'
    as location_picker;
import 'package:role/models/location.dart';

class EventMapScreen extends StatelessWidget {
  final Color color;
  final Location location;

  EventMapScreen({required this.color, required this.location});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: location_picker.MapLocationPicker(
      searchHintText: "pesquise um local...",
      hideMapTypeButton: true,
      hideLocationButton: true,
      currentLatLng: location.latLng,
      topCardMargin: EdgeInsets.all(16),
      bottomCardIcon: Icon(CupertinoIcons.checkmark, size: 28),
      bottomCardMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      bottomCardTooltip: "confirmar local",
      apiKey: "AIzaSyDRphIYLhzVvBg0FVeKTpbGU33JfwBGuFE",
      onNext: (location_picker.GeocodingResult? result) {
        Navigator.pop(
            context,
            Location(
              latitude: result!.geometry.location.lat,
              longitude: result.geometry.location.lng,
              descricao: result.formattedAddress ?? "",
            ));
      },
    ));
  }
}
