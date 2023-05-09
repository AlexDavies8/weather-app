import 'package:flutter/material.dart';
import 'package:weather_app/prototype/arc_progress_indicator.dart';

import 'category_indicator.dart';

class ForecastCard extends StatelessWidget {
  final String label;

  ForecastCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontFamily: "Nunito", fontSize: 20))
              ),
              Expanded(
                flex: 2,
                child: CategoryIndicator(value: 81, icon: Icons.park)
              ),
              Expanded(
                flex: 2,
                child: CategoryIndicator(value: 42, icon: Icons.grass)
              ),
              Expanded(
                flex: 2,
                child: CategoryIndicator(value: 12, icon: Icons.spa)
              )
            ]
          ),
        ],
      )
    );
  }
}