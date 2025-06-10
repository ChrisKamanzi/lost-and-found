import 'package:latlong2/latlong.dart';
class MapState {
  final LatLng? currentLocation;
  final List<LatLng> nearbyLocations;
  final List<String> nearbyNames;
  final bool loading;
  final String? error;


  MapState({
    this.currentLocation,
    this.nearbyLocations = const [],
    this.nearbyNames = const [],
    this.loading = true,
    this.error,

  });

  MapState copyWith({
    LatLng? currentLocation,
    List<LatLng>? nearbyLocations,
    List<String>? nearbyNames,
    bool? loading,
    String? error,

  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      nearbyLocations: nearbyLocations ?? this.nearbyLocations,
      nearbyNames: nearbyNames ?? this.nearbyNames,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}