import 'package:flutter/material.dart';

import 'category_indicator.dart';

class ForecastCard extends StatelessWidget {
  final String label;

  const ForecastCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  flex: 3,
                  child: Text(label,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontFamily: "Nunito", fontSize: 20))),
              const Expanded(
                  flex: 2,
                  child: CategoryIndicator(value: 81, icon: Icons.park)),
              const Expanded(
                  flex: 2,
                  child: CategoryIndicator(value: 42, icon: Icons.grass)),
              const Expanded(
                  flex: 2, child: CategoryIndicator(value: 12, icon: Icons.spa))
            ]),
          ],
        ));
  }
}
