import 'package:flutter/material.dart';
import 'package:weather_app/widgets/parallax_camera.dart';

class ParallaxElement extends StatelessWidget {
  final Widget child;
  final double depth;
  final bool expand;
  final double xOffset;
  final double yOffset;

  const ParallaxElement({
    super.key,
    required this.child,
    this.depth = 0.0,
    this.expand = false,
    this.xOffset = 0,
    this.yOffset = 0
  });

  @override
  Widget build(BuildContext context) {
    final camera = ParallaxCamera.of(context);
    final d1 = depth;
    final d2 = depth - camera.depth;
    final dz = 1 - d1 / d2;
    final x = dz * camera.x + xOffset;
    final y = dz * camera.y + yOffset;
    return Positioned(
      left: x,
      top: y,
      right: expand ? 0 : null,
      bottom: expand ? 0 : null,
      child: child
    );
  }
}