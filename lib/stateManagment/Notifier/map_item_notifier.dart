import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/api.dart';
import '../../models/map_state_model.dart';

class MapItemNotifier extends StateNotifier<MapState> {
  MapItemNotifier() : super(MapState()) {
    fetchLocationData();
  }
String? errorMessage;
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

      final currentCoords = data['current_location']['coordinates'];
      final LatLng currentPos = LatLng(
        (currentCoords['lat'] as num).toDouble(),
        (currentCoords['lng'] as num).toDouble(),
      );

      final List<dynamic> nearbyList = data['nearby_locations'];
      final List<LatLng> nearbyCoords = [];
      final List<String> names = [];

      for (var location in nearbyList) {
        final coords = location['coordinates'];
        nearbyCoords.add(
          LatLng(
            (coords['lat'] as num).toDouble(),
            (coords['lng'] as num).toDouble(),
          ),
        );
        names.add(location['name'] ?? 'Unknown');
      }

      state = state.copyWith(
        currentLocation: currentPos,
        nearbyLocations: nearbyCoords,
        nearbyNames: names,
        loading: false,
      );
    } catch (e) {

      if (e is DioError) {
        errorMessage =
            e.response?.data['message'] ??
                'Something went wrong. Please try again.';
      } else {
        errorMessage = 'An unexpected error occurred.';
      }
      state = state.copyWith(loading: false);
    }
  }

  void goToCoordinates(LatLng newPosition) {
    state = state.copyWith(currentLocation: newPosition);
  }
}

