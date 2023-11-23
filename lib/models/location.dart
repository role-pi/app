import 'package:map_location_picker/map_location_picker.dart';

class Location {
  double _latitude;
  double _longitude;
  String _descricao;

  double get latitude => _latitude;
  set latitude(double value) => _latitude = value;

  double get longitude => _longitude;
  set longitude(double value) => _longitude = value;

  String get descricao => _descricao;
  set descricao(String value) => _descricao = value;

  LatLng get latLng => LatLng(latitude.toDouble(), longitude.toDouble());

  Location({
    required double latitude,
    required double longitude,
    required String descricao,
  })  : _longitude = longitude,
        _latitude = latitude,
        _descricao = descricao;
}
