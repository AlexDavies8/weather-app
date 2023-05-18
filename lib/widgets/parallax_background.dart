import 'package:flutter/material.dart';
import 'package:weather_app/widgets/parallax_camera.dart';
import 'package:weather_app/widgets/parallax_element.dart';

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

          // ParallaxElement(depth: 10000, expand: true, yOffset: 0, child: Image.asset("assets/images/slice1.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 35, xOffset: 150, yOffset: 100, child: Image.asset("assets/images/slice7.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 45, xOffset: -20, yOffset: 200, child: Image.asset("assets/images/slice6.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 30, yOffset: 300, child: Image.asset("assets/images/slice2.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 15, yOffset: 420, child: Image.asset("assets/images/slice3.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 6, xOffset: -10, yOffset: 500, child: Image.asset("assets/images/slice4.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 0, expand: true, yOffset: 1000, child: Container(color: const Color.fromARGB(255, 50, 142, 77))),
          // ParallaxElement(depth: 2, yOffset: 550, child: Image.asset("assets/images/slice5.png", fit: BoxFit.cover)),
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