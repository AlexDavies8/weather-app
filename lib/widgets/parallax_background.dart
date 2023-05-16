import 'package:flutter/material.dart';

class ParallaxBackground extends StatefulWidget {
  final double offset;

  const ParallaxBackground({super.key, required this.offset});

  @override
  State<StatefulWidget> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> with SingleTickerProviderStateMixin {
  
  late Animation<double> animation;
  late AnimationController animController;
  
  @override
  void initState() {
    super.initState();

    animController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
  
    animation = Tween(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(parent: animController, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {});
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ParallaxElement(asset: "assets/images/Layer1.png", camera: widget.offset + animation.value * -200, z: 100, cameraZ: -10),
        ParallaxElement(asset: "assets/images/Layer2.png", camera: widget.offset + animation.value * -200, z: 20, cameraZ: -10),
        ParallaxElement(asset: "assets/images/Layer3.png", camera: widget.offset + animation.value * -200, z: 10, cameraZ: -10),
        ParallaxElement(asset: "assets/images/Layer4.png", camera: widget.offset + animation.value * -200, z: 5, cameraZ: -10),
      ],
    );
  }
}

class ParallaxElement extends StatelessWidget {
  final String asset;
  final double cameraZ;
  final double camera;
  final double z;

  const ParallaxElement({super.key, this.z = 0.0, required this.camera, required this.cameraZ, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: z / (z - cameraZ) * camera - camera,
      child: Image.asset(asset, fit: BoxFit.cover)
    );
  }
}