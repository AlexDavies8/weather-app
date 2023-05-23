import 'package:flutter/material.dart';
import 'package:weather_app/widgets/parallax_camera.dart';
import 'package:weather_app/widgets/parallax_element.dart';

/// Set this to true to use a flat background instead of the parallax effect
const useFlatBackground = false;

/// A class representing a parallax background widget using several [ParallaxElement] layers and a [ParallaxCamera] widget
class ParallaxBackground extends StatefulWidget {
  final double offset;

  const ParallaxBackground({super.key, required this.offset});

  @override
  State<StatefulWidget> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: animController, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {});
      });
    animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 500;

    return ParallaxCamera(
        depth: -10,
        y: (-widget.offset + animation.value * 200) / scaleFactor,
        child: Stack(
          children: buildElements(scaleFactor),
        ));
  }

  List<Widget> buildElements(double scaleFactor) {
    if (useFlatBackground) {
      // Returns a flat background with no parallax effect
      return [
        ParallaxElement(
            depth: 10000,
            expandHeight: true,
            yOffset: 0,
            child: Image.asset("assets/images/slice1.png", fit: BoxFit.cover)),
        ParallaxElement(
            depth: 25,
            xOffset: 150,
            yOffset: 130,
            child: Image.asset("assets/images/slice7.png", fit: BoxFit.cover)),
        ParallaxElement(
            depth: 45,
            xOffset: -20,
            yOffset: 200,
            child: Image.asset("assets/images/slice6.png", fit: BoxFit.cover)),
        ParallaxElement(
            depth: 30,
            yOffset: 300,
            child: Image.asset("assets/images/slice2.png", fit: BoxFit.cover)),
        ParallaxElement(
            depth: 15,
            yOffset: 420,
            child: Image.asset("assets/images/slice3.png", fit: BoxFit.cover)),
        ParallaxElement(
            depth: 6,
            xOffset: -10,
            yOffset: 550,
            child: Image.asset("assets/images/slice4.png", fit: BoxFit.cover)),
        ParallaxElement(
            depth: 0,
            expandHeight: true,
            yOffset: 1000,
            child: Container(color: const Color.fromARGB(255, 50, 142, 77))),
        ParallaxElement(
            depth: 1,
            yOffset: 700,
            child: Image.asset("assets/images/slice5.png", fit: BoxFit.cover)),
      ];
    }
    return [
      // Sky
      ParallaxElement(
        depth: 10000,
        expandHeight: true,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color.fromARGB(255, 73, 206, 255),
                Color.fromARGB(255, 243, 255, 255)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            color: Colors.white,
          ),
        ),
      ),

      // Sun
      ParallaxElement(
        depth: 200,
        expandHeight: true,
        xOffset: 400 * scaleFactor,
        yOffset: 50 * scaleFactor,
        child: Image.asset(
          'assets/images/Sun.png',
          fit: BoxFit.cover,
          color: Colors.yellow,
        ),
      ),

      // Clouds
      ParallaxElement(
          depth: 100,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 237, 237, 237),
                  Color.fromARGB(255, 255, 253, 192)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/images/Clouds.png',
              fit: BoxFit.cover,
            ),
          )),

      // Layer 4
      ParallaxElement(
          depth: 50,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 180, 227, 114),
                  Color.fromARGB(255, 200, 205, 64)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/images/Layer4.png',
              fit: BoxFit.cover,
            ),
          )),

      // Layer 3
      ParallaxElement(
          depth: 30,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 31, 145, 60),
                  Color.fromARGB(255, 49, 88, 72)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/images/Layer3.png',
              fit: BoxFit.cover,
            ),
          )),

      // Layer 2
      ParallaxElement(
          depth: 10,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 83, 182, 103),
                  Color.fromARGB(255, 57, 124, 73)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/images/Layer2.png',
              fit: BoxFit.cover,
            ),
          )),

      // Layer 1
      ParallaxElement(
          depth: 0.1,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 214, 246, 93),
                  Color.fromARGB(255, 50, 142, 77)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/images/Layer1.png',
              fit: BoxFit.cover,
            ),
          )),

      // ParallaxElement(depth: 50, child: Image.asset("assets/images/Layer3.png", fit: BoxFit.cover, color: Color.fromARGB(255, 157, 192, 139))),
      // ParallaxElement(depth: 15, child: Image.asset("assets/images/Layer2.png", fit: BoxFit.cover, color: Color.fromARGB(255, 96, 153, 102))),
      // ParallaxElement(depth: 0.1, child: Image.asset("assets/images/Layer1.png", fit: BoxFit.cover, color: Color.fromARGB(255, 64, 81, 59))),
      ParallaxElement(
          depth: 0.1,
          expandHeight: true,
          yOffset: 1199,
          child: Container(color: const Color.fromARGB(255, 50, 142, 77))),

      // Semi-transparent clouds in front of the sun
      ParallaxElement(
          depth: 10,
          yOffset: 100 * scaleFactor,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(80, 237, 237, 237),
                  Color.fromARGB(90, 231, 227, 98)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/images/Clouds.png',
              fit: BoxFit.cover,
              color: const Color.fromARGB(100, 255, 255, 255),
            ),
          )),
    ];
  }
}
