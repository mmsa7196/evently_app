import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/providers/maps_provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late MapsProvider mapsProvider;
  @override
  Widget build(BuildContext context) {
    return Consumer<MapsProvider>(
      builder: (context, provider, child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            provider.getLocation();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: const Icon(
            Icons.gps_fixed,
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: provider.cameraPosition,
                    mapType: MapType.normal,
                    onMapCreated: (mapController) {
                      provider.mapController = mapController;
                    },
                    markers: provider.markers,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
