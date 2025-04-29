import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _MapScreenState();
}

class _MapScreenState extends State<map> {
  final MapController _mapController = MapController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  LatLng? _currentLocation;
  List<LatLng> _nearbyLocations = [];
  List<String> _nearbyNames = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocationData();
  }

  Future<void> _fetchLocationData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    try {
      final dio = Dio();
      final response = await dio.get(
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
      List<LatLng> nearbyCoords = [];
      List<String> names = [];

      for (var loc in nearby) {
        final coords = loc['coordinates'];
        nearbyCoords.add(LatLng(coords['lat'], coords['lng']));
        names.add(loc['name']);
      }

      setState(() {
        _currentLocation = currentPos;
        _nearbyLocations = nearbyCoords;
        _nearbyNames = names;
        _loading = false;
      });

      _mapController.move(currentPos, 15.0);
    } catch (e) {
      print('Error fetching locations: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  void _goToCoordinates() {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);

    if (lat != null && lng != null) {
      final newPosition = LatLng(lat, lng);
      setState(() {
        _currentLocation = newPosition;
      });
      _mapController.move(newPosition, 15.0);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid coordinates')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAP',
          style: GoogleFonts.brawler(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialZoom: 15.0,
                        initialCenter: _currentLocation ?? const LatLng(0, 0),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            if (_currentLocation != null)
                              Marker(
                                point: _currentLocation!,
                                width: 80,
                                height: 80,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            for (int i = 0; i < _nearbyLocations.length; i++)
                              Marker(
                                point: _nearbyLocations[i],
                                width: 80,
                                height: 80,
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      color: Colors.blue,
                                      size: 35,
                                    ),
                                    Text(
                                      _nearbyNames[i],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
