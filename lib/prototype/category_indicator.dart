import 'package:flutter/material.dart';
import 'package:weather_app/prototype/arc_progress_indicator.dart';

class CategoryIndicator extends StatelessWidget {
  final int min;
  final int max;
  final int value;
  final String? label;
  final IconData? icon;

  const CategoryIndicator({super.key, this.min = 0, this.max = 100, required this.value, this.label, this.icon});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: ArcProgressIndicator(
                  (value - min) / (max - min),
                  label: value.toString(),
                  minArc: -225,
                  maxArc: 45,
                  strokeWidth: 8,
                  backgroundColor: Colors.white12,
                  fillColor: Colors.lightGreen,
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