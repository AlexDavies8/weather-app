import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/forecast/forecast_state.dart';
import 'package:weather_app/utils/iterable_extensions.dart';
import 'package:weather_app/utils/list_extensions.dart';
import 'package:weather_app/widgets/arc_progress_indicator.dart';
import 'package:weather_app/widgets/category_indicator.dart';
import 'package:weather_app/widgets/main_appbar.dart';
import 'package:weather_app/widgets/parallax_background.dart';
import 'package:weather_app/widgets/large_indicator.dart';
import 'package:weather_app/widgets/forecast_card.dart';
import 'dart:math' as Math;

import '../bloc/forecast/forecast_bloc.dart';

const _greenCol = Color.fromARGB(255, 20, 78, 71);
const _yellowCol = Color.fromARGB(255, 133, 188, 93);
const _orangeCol = Color.fromARGB(255, 255, 217, 64);
const _redCol = Color.fromARGB(255, 200, 52, 69);
const _arcIndicatorGradient = IndicatorGradient(
  colours: [_greenCol, _greenCol, _yellowCol, _yellowCol, _orangeCol, _orangeCol, _redCol, _redCol],
  stops: [0.00, 0.30, 0.30, 0.50, 0.50, 0.70, 0.70, 1.00]
);

const days = [
  "Today",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double scrollOffset = 0;

  bool _onScroll(ScrollNotification notification) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      scrollOffset = notification.metrics.pixels;
    }));
    
    return true;
  }
  bool feedback = true;
  Container _buildEmotionIcon(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child:
        Opacity(
          opacity: 1.00,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: Icon(icon),
            iconSize: 45,
            color: Colors.white,
            onPressed: () => setState (() => feedback = false),
            )
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    final forecastBloc = BlocProvider.of<ForecastBloc>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
        child: BlocBuilder<ForecastBloc, ForecastState>(
            bloc: forecastBloc,
            builder: (context, state) {
              if (state.forecast == null) {
                return const SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                  )
                );
              }
              final current = state.forecast!.current.data[0];
              final forecasts = state.forecast!.forecast.data.groupN(24);
              final forecastTimes = forecasts.map((g) => g.skip(12).first).map((el) => DateTime.fromMillisecondsSinceEpoch(el.time! * 1000).weekday);
              final forecastCounts = forecasts
                .map((g) => g
                  .map((e) => [e.count.treePollen.toDouble(), e.count.grassPollen.toDouble(), e.count.weedPollen.toDouble()])
                  .reduce((acc, el) => [acc[0] + el[0], acc[1] + el[1], acc[2] + el[2]])
                  .map((e) => (e / g.length).toInt()).toList()
                );
              final forecastData = [[0, [current.count.treePollen, current.count.grassPollen, current.count.weedPollen]]] + [forecastTimes, forecastCounts].zip().toList();
              final currentScore = current.count.grassPollen + current.count.treePollen + current.count.weedPollen;
              final currentRating = currentScore < 200 ? "Low" : currentScore < 400 ? "Medium" : currentScore < 600 ? "High" : "Very High";
              return _MainPageWrapper(
                title: state.selectedLocation!.displayName,
                scrollOffset: scrollOffset,
                children: [
                  const SizedBox(height: 150),
                  Container(
                    padding: const EdgeInsets.only(top: 60, left: 60, right: 60),
                    child: Column(
                      children: [
                        LargeIndicator(min: 0, max: 800, value: currentScore, gradient: _arcIndicatorGradient),
                        Text(
                            currentRating,
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Varela"
                        ),
                            ),
                          AnimatedOpacity(
                            opacity: feedback ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                            padding: const EdgeInsets.only(top: 42, left: 30, right: 30),
                            child: Column(
                              children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildEmotionIcon(Icons.sentiment_very_dissatisfied, 'Unhappy'),
                                    _buildEmotionIcon(Icons.sentiment_satisfied, 'Neutral'),
                                    _buildEmotionIcon(Icons.sentiment_very_satisfied, 'Happy')
                                  ],
                                ),
                              ),
                                const Text("How do you feel today?", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Varela"),)
                              ]
                            )
                          )
                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CategoryIndicator(value: current.count.treePollen, label: "Trees", icon: Icons.park),
                        CategoryIndicator(value: current.count.grassPollen, label: "Grasses", icon: Icons.grass),
                        CategoryIndicator(value: current.count.weedPollen, label: "Weeds", icon: Icons.spa),
                      ]
                    )
                  ),
                  const SizedBox(height: 12),
                  Container(
                    color: Colors.white24,
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: Column(
                      children: forecastData.map((data) => ForecastCard(
                        label: days[data[0] as int],
                        trees: (data[1] as List<int>)[0],
                        grasses: (data[1] as List<int>)[1],
                        weeds: (data[1] as List<int>)[2],
                      )).toList()
                    )
                  )
                ]
              );
            }
          ),
      );
  }
}

class _MainPageWrapper extends StatelessWidget {
  final List<Widget> children;
  final double scrollOffset;
  final String title;

  const _MainPageWrapper({required this.children, this.scrollOffset = 0, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(title: title),
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