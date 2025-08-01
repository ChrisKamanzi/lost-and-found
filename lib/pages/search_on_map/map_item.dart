import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../stateManagment/provider/map_item_provider.dart';

class MapItem extends ConsumerStatefulWidget {
  const MapItem({super.key});

  @override
  ConsumerState<MapItem> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapItem> {
  final MapController mapController = MapController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();

  @override
  void didUpdateWidget(covariant MapItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    final state = ref.read(mapItemProvider);
    if (state.currentLocation != null) {
      mapController.move(state.currentLocation!, 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapItemProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAP Item',
          style: GoogleFonts.brawler(
            textStyle:  TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body:
      mapState.loading
          ?  Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialZoom: 15.0,
                initialCenter:
                mapState.currentLocation ??  LatLng(0, 0),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    if (mapState.currentLocation != null)
                      Marker(
                        point: mapState.currentLocation!,
                        width: 80,
                        height: 80,
                        child:  Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    for (int i = 0; i < mapState.nearbyLocations.length; i++)
                      Marker(
                        point: mapState.nearbyLocations[i],
                        width: 80,
                        height: 80,
                        child: Column(
                          children: [
                             Icon(
                              Icons.place,
                              color: Colors.blue,
                              size: 35,
                            ),
                            Text(
                              mapState.nearbyNames[i],
                              style:  TextStyle(
                                fontSize: 10,
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
