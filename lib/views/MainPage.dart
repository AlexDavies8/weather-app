import 'package:flutter/material.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/forecast_bloc.dart';

import '../models/pollen_data.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ForecastBloc(),
      child: TodayWidget()
    );
  }
}

class TodayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final forecastBloc = BlocProvider.of<ForecastBloc>(context);
    return StreamBuilder<List<PollenData>?>(
      stream: forecastBloc.forecastStream,
      builder: (context, snapshot) {
        return Text(snapshot.data?[0].trees.toString() ?? "No Data");
      }
    );
  }

}