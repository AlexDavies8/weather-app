import 'package:flutter/material.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/forecast_bloc.dart';
import 'package:weather_app/prototype/ambee_api.dart';
import 'package:weather_app/utils/iterable_extensions.dart';
import 'package:weather_app/utils/list_extensions.dart';
import 'package:weather_app/widgets/arc_progress_indicator.dart';
import 'package:weather_app/widgets/category_indicator.dart';
import 'package:weather_app/widgets/main_appbar.dart';
import 'package:weather_app/widgets/parallax_background.dart';
import 'package:weather_app/widgets/large_indicator.dart';
import 'package:weather_app/widgets/forecast_card.dart';
import 'package:weather_app/models/pollen_forecast.dart';

const _greenCol = Color.fromARGB(255, 20, 78, 71);
const _yellowCol = Color.fromARGB(255, 133, 188, 93);
const _orangeCol = Color.fromARGB(255, 255, 208, 105);
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
    setState(() {
      scrollOffset = notification.metrics.pixels;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final forecastBloc = BlocProvider.of<ForecastBloc>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: _MainPageWrapper(
        scrollOffset: scrollOffset,
        children: [
          StreamBuilder<PollenForecast>(
            stream: forecastBloc.forecast,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SafeArea(child: Center(child: CircularProgressIndicator()));
              }
              final current = snapshot.data!.current.data[0];
              final forecasts = snapshot.data!.forecast.data.groupN(24);
              final forecastTimes = forecasts.map((g) => g.skip(12).first).map((el) => DateTime.fromMillisecondsSinceEpoch(el.time! * 1000).weekday);
              final forecastCounts = forecasts
                .map((g) => g
                  .map((e) => [e.count.treePollen.toDouble(), e.count.grassPollen.toDouble(), e.count.weedPollen.toDouble()])
                  .reduce((acc, el) => [acc[0] + el[0], acc[1] + el[1], acc[2] + el[2]])
                  .map((e) => (e / g.length).toInt()).toList()
                );
              final forecastData = [[0, [current.count.treePollen, current.count.grassPollen, current.count.weedPollen]]] + [forecastTimes, forecastCounts].zip().toList();
              return Column(
                children: [
                  const SizedBox(height: 150),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(60),
                      child: LargeIndicator(min: 0, max: 100, value: 74, gradient: _arcIndicatorGradient)
                    )
                  ),
                  const SizedBox(height: 132),
                  Padding(
                    padding: EdgeInsets.all(40),
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
        ]
      )
    );
  }
}

class TodayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forecastBloc = BlocProvider.of<ForecastBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: StreamBuilder<PollenForecast>(
        stream: forecastBloc.forecast,
        builder: (context, snapshot) {
          return Text(snapshot.data?.forecast.data[0].count.treePollen.toString() ?? "No Data");
        }
      )
    );
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