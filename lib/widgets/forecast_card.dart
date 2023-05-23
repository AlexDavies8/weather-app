import 'package:flutter/material.dart';

import 'category_indicator.dart';

/// Custom card to display a forecast for a given future day
class ForecastCard extends StatelessWidget {
  final String label;
  final int trees;
  final int grasses;
  final int weeds;

  const ForecastCard(
      {super.key,
      required this.label,
      this.trees = 0,
      this.grasses = 0,
      this.weeds = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // Day of week
              Expanded(
                  flex: 4,
                  child: Text(label,
                      textAlign: TextAlign.right,
                      style:
                          const TextStyle(fontFamily: "Nunito", fontSize: 20))),
              // Spacer
              Expanded(flex: 1, child: Container()),
              // Category indicators for trees, grasses, and weeds
              Expanded(
                  flex: 4,
                  child: CategoryIndicator(value: trees, icon: Icons.park)),
              Expanded(
                  flex: 4,
                  child: CategoryIndicator(value: grasses, icon: Icons.grass)),
              Expanded(
                  flex: 4,
                  child: CategoryIndicator(value: weeds, icon: Icons.spa))
            ]),
          ],
        ));
  }
}
