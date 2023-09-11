import 'package:latlong2/latlong.dart';

class Endereco {
  double _latitude;
  double _longitude;
  String _descricao;

  double get latitude => _latitude;
  set latitude(double value) => _latitude = value;

  double get longitude => _longitude;
  set longitude(double value) => _longitude = value;

  String get descricao => _descricao;
  set descricao(String value) => _descricao = value;

  LatLng get coordenadas => LatLng(latitude.toDouble(), longitude.toDouble());

  Endereco({
    required double latitude,
    required double longitude,
    required String descricao,
  })  : _longitude = longitude,
        _latitude = latitude,
        _descricao = descricao;
}
