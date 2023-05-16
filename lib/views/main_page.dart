import 'package:flutter/material.dart';
import 'package:weather_app/apis/ambee_api.dart';
import 'package:weather_app/bloc/bloc_provider.dart';
import 'package:weather_app/bloc/forecast_bloc.dart';

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