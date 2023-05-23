import 'package:flutter/material.dart';
import 'package:weather_app/widgets/arc_progress_indicator.dart';

/// Custom Indicator class to render a large speedometer-style indicator arc using the [ArcProgressIndicator] class
class LargeIndicator extends StatefulWidget {
  final int min;
  final int max;
  final int value;
  final IndicatorGradient gradient;

  const LargeIndicator(
      {super.key,
      required this.value,
      this.min = 0,
      this.max = 100,
      required this.gradient});

  @override
  State<StatefulWidget> createState() => _LargeIndicatorState();
}

class _LargeIndicatorState extends State<LargeIndicator> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: ArcProgressIndicator(
          progress: (widget.value - widget.min) / (widget.max - widget.min),
          label: widget.value.toString(),
          backgroundColor: Colors.white.withOpacity(0.2),
          gradient: widget.gradient,
          minArc: -225,
          maxArc: 45,
        ));
  }
}
