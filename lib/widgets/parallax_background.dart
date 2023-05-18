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
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 1000;

    return ParallaxCamera(
      depth: -10,
      y: -widget.offset + animation.value * 200,
      child: Stack(
        children: [
          


          // Sky
          ParallaxElement(depth: 10000, expandHeight: true, child: 
            ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(255, 73, 206, 255), Color.fromARGB(255, 243, 255, 255)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Container(
                    color:Colors.white,
                  ),
              ),
          ),

          //Sun
          ParallaxElement(depth: 1, expandHeight: true, xOffset: 400, yOffset:50, child: Image.asset(
                    'assets/images/Sun.png',
                    fit: BoxFit.cover,
                    color:Colors.yellow,
                  ),
          ),

          //Clouds
          ParallaxElement(depth: 100, child: 
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(255, 237, 237, 237), Color.fromARGB(255, 231, 226, 98)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    'assets/images/Clouds.png',
                    fit: BoxFit.cover,
                  ),
              )
          ),

          //Layer 4
          ParallaxElement(depth: 50, child: 
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(255, 188, 188, 21),Color.fromARGB(255, 255, 255, 255)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    'assets/images/Layer4.png',
                    fit: BoxFit.cover,
                  ),
              )
          ),

          //Layer 3
          ParallaxElement(depth: 30, child: 
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(255, 89, 168, 56),Color.fromARGB(255, 204, 245, 165)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    'assets/images/Layer3.png',
                    fit: BoxFit.cover,
                  ),
              )
          ),

          //Layer 2
          ParallaxElement(depth: 10, child: 
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(255, 38, 122, 2),Color.fromARGB(255, 136, 161, 129)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    'assets/images/Layer2.png',
                    fit: BoxFit.cover,
                  ),
              )
          ),

          //Layer 2
          ParallaxElement(depth: 0.1, child: 
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(255, 0, 0, 0),Color.fromARGB(255, 10, 102, 53)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child:  Image.asset(
                    'assets/images/Layer1.png',
                    fit: BoxFit.cover,
                  ),
              )
          ),

          // ParallaxElement(depth: 50, child: Image.asset("assets/images/Layer3.png", fit: BoxFit.cover, color: Color.fromARGB(255, 157, 192, 139))),
          // ParallaxElement(depth: 15, child: Image.asset("assets/images/Layer2.png", fit: BoxFit.cover, color: Color.fromARGB(255, 96, 153, 102))),
          // ParallaxElement(depth: 0.1, child: Image.asset("assets/images/Layer1.png", fit: BoxFit.cover, color: Color.fromARGB(255, 64, 81, 59))),
          ParallaxElement(depth: 0.1, expandHeight: true, yOffset: 1000*scaleFactor, child: Container(color: Color.fromARGB(255, 6, 79, 40))),

          //Clouds Again
          ParallaxElement(depth: 10, yOffset: 100*scaleFactor, child: 
              ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color.fromARGB(80, 237, 237, 237), Color.fromARGB(90, 231, 227, 98)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    'assets/images/Clouds.png',
                    fit: BoxFit.cover,
                    color: Color.fromARGB(124, 255, 255, 255),
                  ),
              )
          ),

          // ParallaxElement(depth: 10000, expandHeight: true, yOffset: 0, child: Image.asset("assets/images/slice1.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 35, xOffset: 150, yOffset: 100, child: Image.asset("assets/images/slice7.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 45, xOffset: -20, yOffset: 200, child: Image.asset("assets/images/slice6.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 30, yOffset: 300, child: Image.asset("assets/images/slice2.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 15, yOffset: 420, child: Image.asset("assets/images/slice3.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 6, xOffset: -10, yOffset: 500, child: Image.asset("assets/images/slice4.png", fit: BoxFit.cover)),
          // ParallaxElement(depth: 0, expandHeight: true, yOffset: 1000, child: Container(color: const Color.fromARGB(255, 50, 142, 77))),
          // ParallaxElement(depth: 2, yOffset: 550, child: Image.asset("assets/images/slice5.png", fit: BoxFit.cover)),
        ],
      )
    ) ;
  }
}