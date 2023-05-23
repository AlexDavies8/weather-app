import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/apis/keys.dart';

/// The page for the heatmap
class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Heatmap")),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                center: LatLng(
                    52.211062401143174, 0.09145702047173837), // Cambridge
                zoom: 10.0,
                maxZoom: 10,
                minZoom: 2,
                maxBounds: LatLngBounds(
                  LatLng(85.0, -180.0),
                  LatLng(-85.0, 180.0),
                ), // Prevents the user from scrolling outside the map
                interactiveFlags: InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag
                        .pinchZoom), // Prevents the user from rotating the map
            children: [
              // The base map, provided by OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              // The heatmap tiles, provided by Breezometer
              TileLayer(
                urlTemplate:
                    'https://tiles.breezometer.com/v1/pollen/tree/forecast/daily/{z}/{x}/{y}.png?key={key}',
                // The fallback URL is used when the tile is not available for certain regions
                fallbackUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/4/48/BLANK_ICON.png',
                backgroundColor: Colors.transparent,
                tileDisplay: const TileDisplay.instantaneous(opacity: 0.65),
                additionalOptions: const {
                  'key': Keys.breezometer,
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
