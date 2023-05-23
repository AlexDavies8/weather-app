import 'package:flutter/material.dart';
import 'package:weather_app/prototype/arc_progress_indicator.dart';
import 'dart:math' as Math;

const colours = [
  Color.fromARGB(255, 13, 100, 51),
  Color.fromARGB(255, 133, 188, 93),
  Color.fromARGB(255, 255, 217, 64),
  Color.fromARGB(255, 255, 127, 52),
  Color.fromARGB(255, 200, 52, 69),
];

class CategoryIndicator extends StatelessWidget {
  final int min;
  final int max;
  final int value;
  final String? label;
  final IconData? icon;

  const CategoryIndicator({super.key, this.min = 0, this.max = 500, required this.value, this.label, this.icon});
  
  @override
  Widget build(BuildContext context) {
    final clampedValue = Math.max(Math.min(value, max), min);
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: ArcProgressIndicator(
                  (clampedValue - min) / (max - min),
                  label: value.toString(),
                  minArc: -225,
                  maxArc: 45,
                  strokeWidth: 8,
                  backgroundColor: Colors.white12,
                  fillColor: colours[clampedValue ~/ ((max+1) ~/ 5)],
                )
              ),
              if (icon != null) Positioned(
                bottom: 0,
                child: Icon(icon!, color: Colors.white, size: 24)
              ),
            ],
          )
        ),
        const SizedBox(height: 4),
        if (label != null) Text(label!, style: const TextStyle(fontFamily: "Nunito", fontSize: 16)),
      ]
    );
  }
}