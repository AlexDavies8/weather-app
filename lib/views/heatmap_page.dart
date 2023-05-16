import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/apis/keys.dart';

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
                center: LatLng(52.211062401143174, 0.09145702047173837),
                zoom: 3.2,
                maxZoom: 8,
                minZoom: 2,
                maxBounds: LatLngBounds(
                  LatLng(85.0, -180.0),
                  LatLng(-85.0, 180.0),
                ),
                interactiveFlags: InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              TileLayer(
                urlTemplate:
                    'https://tiles.breezometer.com/v1/pollen/tree/forecast/daily/{z}/{x}/{y}.png?key={key}',
                fallbackUrl:
                    'https://upload.wikimedia.org/wikipedia/en/9/98/Blank_button.svg',
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
