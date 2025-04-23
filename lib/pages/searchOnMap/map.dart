import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:lost_and_found/widgets/text_field.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _MapScreenState();
}

class _MapScreenState extends State<map> {
  final MapController _mapController = MapController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  LatLng? _markerPosition;

  void _goToCoordinates() {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);

    if (lat != null && lng != null) {
      final newPosition = LatLng(lat, lng);
      setState(() {
        _markerPosition = newPosition;
      });
      _mapController.move(newPosition, 15.0);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid coordinates')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          'Localize your Item',
        style: GoogleFonts.brawler(
          textStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800
          )
        ),

      )
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: textfield(
                    controller: _latController,
                    hintText: 'Latitude',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: textfield(
                    controller: _lngController,
                    hintText: 'Longitude',
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _goToCoordinates, child: Text('Go')),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialZoom: 8.5,
                initialCenter: LatLng(-2.0000000, 30.0000000),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                if (_markerPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _markerPosition!,
                        width: 80,
                        height: 80,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
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
