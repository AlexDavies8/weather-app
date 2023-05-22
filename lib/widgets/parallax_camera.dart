import 'package:flutter/material.dart';

/// A class representing a camera widget to create parallax effects
class ParallaxCamera extends StatelessWidget {
  final Widget child;
  final double x;
  final double y;
  final double depth;

  const ParallaxCamera({
    required this.child,
    this.x = 0,
    this.y = 0,
    this.depth = 0,
    super.key
  });

  static ParallaxCamera of(BuildContext context) {
    return context.findAncestorWidgetOfExactType()!;
  }
  
  @override
  Widget build(BuildContext context) => child;
}