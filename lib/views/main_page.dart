import 'package:flutter/material.dart';
import 'package:weather_app/apis/ambee_api.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/forecast_bloc.dart';
import 'package:weather_app/widgets/arc_progress_indicator.dart';
import 'package:weather_app/widgets/category_indicator.dart';
import 'package:weather_app/widgets/main_appbar.dart';
import 'package:weather_app/widgets/parallax_background.dart';
import 'package:weather_app/widgets/large_indicator.dart';
import 'package:weather_app/widgets/forecast_card.dart';

<<<<<<< HEAD
import '../models/pollen_data.dart';

const _greenCol = Color.fromARGB(255, 20, 78, 71);
const _yellowCol = Color.fromARGB(255, 133, 188, 93);
const _orangeCol = Color.fromARGB(255, 255, 208, 105);
const _redCol = Color.fromARGB(255, 200, 52, 69);
const _arcIndicatorGradient = IndicatorGradient(
  colours: [_greenCol, _greenCol, _yellowCol, _yellowCol, _orangeCol, _orangeCol, _redCol, _redCol],
  stops: [0.00, 0.30, 0.30, 0.50, 0.50, 0.70, 0.70, 1.00]
);


=======
>>>>>>> 7df0b6f7a402440167a86a7f69dc234a5ac92a7d
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
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: _MainPageWrapper(
        scrollOffset: scrollOffset,
        children: [
          const SizedBox(height: 150),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: LargeIndicator(min: 0, max: 100, value: 74, gradient: _arcIndicatorGradient)
            )
          ),
          const SizedBox(height: 132),
          const Card(
            elevation: 0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            margin: EdgeInsets.zero,
            child: ClipRect(
              child:  Padding(
                padding: EdgeInsets.all(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
  }
}

class TodayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forecastBloc = BlocProvider.of<ForecastBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: StreamBuilder<PollenData>(
        stream: forecastBloc.forecast,
        builder: (context, snapshot) {
          return Text(snapshot.data?.data[0].count.treePollen.toString() ?? "No Data");
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