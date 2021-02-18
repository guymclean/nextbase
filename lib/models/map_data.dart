import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nextbase/util/extensions.dart';

class MapData extends Equatable {
  final List<LatLng> coordinates;
  final LatLngBounds bounds;

  MapData(this.coordinates) : bounds = _calculateBounds(coordinates);

  static LatLngBounds _calculateBounds(List<LatLng> coordinates) {
    return LatLngBounds(
      southwest: LatLng(
        coordinates.map((LatLng coordinate) => coordinate.latitude).min,
        coordinates.map((LatLng coordinate) => coordinate.longitude).min,
      ),
      northeast: LatLng(
        coordinates.map((LatLng coordinate) => coordinate.latitude).max,
        coordinates.map((LatLng coordinate) => coordinate.longitude).max,
      ),
    );
  }

  @override
  List<Object> get props => [
        coordinates,
        bounds,
      ];

  @override
  bool get stringify => true;
}
