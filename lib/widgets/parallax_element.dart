import 'package:flutter/material.dart';
import 'package:weather_app/widgets/parallax_camera.dart';

class ParallaxElement extends StatelessWidget {
  final Widget child;
  final double depth;

  const ParallaxElement({
    super.key,
    required this.child,
    this.depth = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final camera = ParallaxCamera.of(context);
    final dz = depth / (depth - camera.depth) + 1;
    final x = dz * camera.x;
    final y = dz * camera.y;
    return Positioned(
      left: 0,
      top: y,
      right: 0,
      child: child
    );
  }
}