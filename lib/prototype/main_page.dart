import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:weather_app/prototype/ambee_api.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/prototype/arc_progress_indicator.dart';
import 'package:weather_app/prototype/category_indicator.dart';
import 'package:weather_app/prototype/main_appbar.dart';
import 'package:weather_app/widgets/parallax_background.dart';

import 'forecast_card.dart';
import 'large_indicator.dart';

const _greenCol = Color.fromARGB(255, 20, 78, 71);
const _yellowCol = Color.fromARGB(255, 133, 188, 93);
const _orangeCol = Color.fromARGB(255, 255, 208, 105);
const _redCol = Color.fromARGB(255, 200, 52, 69);
const _arcIndicatorGradient = IndicatorGradient(
  colours: [_greenCol, _greenCol, _yellowCol, _yellowCol, _orangeCol, _orangeCol, _redCol, _redCol],
  stops: [0.00, 0.30, 0.30, 0.50, 0.50, 0.70, 0.70, 1.00]
);

class MainPage extends StatefulWidget {
  final AmbeeApi ambeeApi;

  const MainPage(this.ambeeApi, {super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double scrollOffset = 0;

  bool _onScroll(ScrollNotification notification) {
    setState(() {
      scrollOffset = notification.metrics.pixels;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: _MainPageWrapper(
        scrollOffset: scrollOffset,
        children: [
          const SizedBox(height: 150),
          Center(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: LargeIndicator(min: 0, max: 100, value: 74, gradient: _arcIndicatorGradient)
            )
          ),
          const SizedBox(height: 132),
          Card(
            elevation: 0,
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            margin: EdgeInsets.zero,
            child: ClipRect(
              child:  Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const[
                    CategoryIndicator(value: 81, label: "Trees", icon: Icons.park),
                    CategoryIndicator(value: 44, label: "Grasses", icon: Icons.grass),
                    CategoryIndicator(value: 56, label: "Weeds", icon: Icons.spa),
                  ]
                )
              )
            )
          ),
          const SizedBox(height: 12),
          Container(
            color: Colors.white24,
            height: 2,
          ),
          Card(
            elevation: 0,
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  ForecastCard(label: "Saturday"),
                  ForecastCard(label: "Sunday"),
                  ForecastCard(label: "Monday"),
                  ForecastCard(label: "Tuesday"),
                  ForecastCard(label: "Wednesday"),
                  ForecastCard(label: "Thursday"),
                  ForecastCard(label: "Friday"),
                ]
              )
            )
          )
        ]
      )
    );
        // Positioned(
        //     bottom: 0,
        //     left: 0,
        //     right: 0,
        // child: Padding(
        //       padding: EdgeInsets.all(20),
        //       child: Card(
        //         color: Color.fromARGB(255, 126, 0, 48),
        //         elevation: 8,
        //         child: Padding(
        //           padding: EdgeInsets.all(20),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.stretch,
        //             children: [
        //               Text("How is your hayfever today?", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: "Nunito")),
        //               SizedBox(height: 10),
        //               Text("🤧   😐   😄", textAlign: TextAlign.center, style: TextStyle(fontSize: 36))
        //             ],
        //           )
        //         )
        //       )
        //     )
        // ),
  }

  List<Widget> _generateForecastWidgets() {
    final rand = Random(0);
    List<Widget> widgets = ["Today", "Tomorrow", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"].map(
      (day) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white24, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CategoryIndicator(value: rand.nextInt(100), icon: Icons.park),
                    CategoryIndicator(value: rand.nextInt(100), icon: Icons.grass),
                    CategoryIndicator(value: rand.nextInt(100), icon: Icons.spa),
                  ]
                )
              )
            )
          ),
          Positioned(
            left: 20,
            top: 1,
            child: Text(day, style: const TextStyle(fontFamily: "Nunito", fontSize: 16, backgroundColor: Color.fromARGB(255, 33, 12, 33)))
          )
        ]
      )
    ).toList();

    return widgets;
  }
}

class _MainPageWrapper extends StatelessWidget {
  final List<Widget> children;
  final double scrollOffset;

  const _MainPageWrapper({required this.children, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(),
      body: Stack(
        children: [
          ParallaxBackground(offset: scrollOffset),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              )
            )
          )
        ],
      )
    );
  }
}