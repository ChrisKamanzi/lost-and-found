import 'package:latlong2/latlong.dart';
class MapState {
  final LatLng? currentLocation;
  final List<LatLng> nearbyLocations;
  final List<String> nearbyNames;
  final bool loading;

  MapState({
    this.currentLocation,
    this.nearbyLocations = const [],
    this.nearbyNames = const [],
    this.loading = true,
  });

  MapState copyWith({
    LatLng? currentLocation,
    List<LatLng>? nearbyLocations,
    List<String>? nearbyNames,
    bool? loading,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      nearbyLocations: nearbyLocations ?? this.nearbyLocations,
      nearbyNames: nearbyNames ?? this.nearbyNames,
      loading: loading ?? this.loading,
    );
  }
}