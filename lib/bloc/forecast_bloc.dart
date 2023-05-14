import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:weather_app/bloc/bloc.dart';
import 'package:weather_app/models/pollen_data.dart';

class ForecastBloc extends Bloc {
  final StreamController _forecastController = StreamController<String?>();
  Sink<String?> get forecast => _forecastController.sink as Sink<String?>;
  
  late Stream<List<PollenData>?> forecastStream;

  ForecastBloc() {
    forecastStream = _forecastController.stream
      .startWith(null)
      .delay(Duration(seconds: 5))
      .asyncMap((placename) => [
        PollenData(trees: 50, grasses: 24, weeds: 72),
        PollenData(trees: 42, grasses: 32, weeds: 56),
        PollenData(trees: 20, grasses: 36, weeds: 48),
        PollenData(trees: 29, grasses: 31, weeds: 45),
        PollenData(trees: 32, grasses: 32, weeds: 48)
      ]);
    forecast.add("test");
  }
  
  @override
  void dispose() {
    _forecastController.close();
  }
}