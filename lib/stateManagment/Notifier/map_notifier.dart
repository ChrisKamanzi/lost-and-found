import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/api.dart';
import '../../models/map_model.dart';

class MapNotifier extends StateNotifier<MapState> {
  MapNotifier() : super(MapState()) {
    fetchLocationData();
  }

  final Dio _dio = Dio();

  Future<void> fetchLocationData() async {
    state = state.copyWith(loading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
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
      final currentCoordinates = data['current_location']['coordinates'];
      final LatLng currentPos = LatLng(
        currentCoordinates['lat'],
        currentCoordinates['lng'],
      );

      List<dynamic> nearby = data['nearby_locations'];
      List<LatLng> coords = [];
      List<String> names = [];

      for (var loc in nearby) {
        final locCoords = loc['coordinates'];
        coords.add(LatLng(locCoords['lat'], locCoords['lng']));
        names.add(loc['name']);
      }

      state = state.copyWith(
        currentLocation: currentPos,
        nearbyLocations: coords,
        nearbyNames: names,
        loading: false,
      );
    } catch (e) {
      print("Error: $e");
      state = state.copyWith(loading: false);
    }
  }

  void goToCoordinates(LatLng newPosition) {
    state = state.copyWith(currentLocation: newPosition);
  }
}
