import 'package:flutter/cupertino.dart';
import 'package:map_location_picker/map_location_picker.dart'
    as location_picker;
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/models/location.dart';
import 'package:role/shared/utils/constants.dart';

class EventMapScreen extends StatelessWidget {
  late final EventEditProvider provider;

  EventMapScreen(EventEditProvider eventEditProvider) {
    this.provider = eventEditProvider;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: location_picker.MapLocationPicker(
      searchHintText: "pesquise um local...",
      hideMapTypeButton: true,
      hideLocationButton: true,
      currentLatLng: provider.event.location.latLng,
      topCardMargin: EdgeInsets.all(16),
      bottomCardIcon: Icon(CupertinoIcons.checkmark, size: 28),
      bottomCardMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      bottomCardTooltip: "confirmar local",
      apiKey: apiKey,
      onNext: (location_picker.GeocodingResult? result) {
        provider.updateLocation(Location(
          latitude: result!.geometry.location.lat,
          longitude: result.geometry.location.lng,
          descricao: result.formattedAddress ?? "",
        ));
        Navigator.pop(context);
      },
    ));
  }
}
