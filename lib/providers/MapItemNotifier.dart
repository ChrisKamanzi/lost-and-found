import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/api.dart';

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

class MapItemNotifier extends StateNotifier<MapState> {
  MapItemNotifier() : super(MapState()) {
    fetchLocationData();
  }

  final Dio _dio = Dio();

  Future<void> fetchLocationData() async {
    state = state.copyWith(loading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        throw Exception("Auth token not found.");
      }

      final response = await _dio.get(
        '$apiUrl/user/near-by-locations',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final data = response.data['near-locations'];

      // Parse current location
      final currentCoords = data['current_location']['coordinates'];
      final LatLng currentPos = LatLng(
        (currentCoords['lat'] as num).toDouble(),
        (currentCoords['lng'] as num).toDouble(),
      );

      // Parse nearby locations
      final List<dynamic> nearbyList = data['nearby_locations'];
      final List<LatLng> nearbyCoords = [];
      final List<String> names = [];

      for (var location in nearbyList) {
        final coords = location['coordinates'];
        nearbyCoords.add(LatLng(
          (coords['lat'] as num).toDouble(),
          (coords['lng'] as num).toDouble(),
        ));
        names.add(location['name'] ?? 'Unknown');
      }

      state = state.copyWith(
        currentLocation: currentPos,
        nearbyLocations: nearbyCoords,
        nearbyNames: names,
        loading: false,
      );
    } catch (e) {
      print('MapNotifier Error: $e');
      state = state.copyWith(loading: false);
    }
  }

  void goToCoordinates(LatLng newPosition) {
    state = state.copyWith(currentLocation: newPosition);
  }
}

final mapItemProvider = StateNotifierProvider<MapItemNotifier, MapState>((ref) => MapItemNotifier());
