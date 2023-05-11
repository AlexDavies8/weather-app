import 'dart:async';

import 'package:weather_app/bloc/bloc.dart';
import 'package:weather_app/models/pollen_data.dart';

class ForecastBloc extends Bloc {
  @override
  void dispose() {
    // TODO: implement dispose
  }
  //final StreamController _forecastController = StreamController<List<PollenData>>();
  //Sink<List<PollenData>> get forecast => _forecastController.sink;
}