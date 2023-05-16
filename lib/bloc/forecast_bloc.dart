import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:weather_app/apis/ambee_api.dart';
import 'package:weather_app/bloc/bloc.dart';
import 'package:weather_app/models/location.dart';

class ForecastBloc extends Bloc {
  final StreamController _forecastController = StreamController<String?>();
  Sink<RequestLocation> get queryLocation => _forecastController.sink as Sink<RequestLocation>;
  
  late Stream<PollenData> forecast;

  late AmbeeApi ambeeApi;

  ForecastBloc() {
    ambeeApi = const AmbeeApi();
    forecast = _forecastController.stream
      .startWith(null)
      .delay(const Duration(seconds: 5))
      .asyncMap((location) async {
        if (location is PlacewiseLocation) {
          return await ambeeApi.getPollenFuturePlacewise(location.placename);
        } else if (location is LatLngLocation) {
          return await ambeeApi.getPollenGeospatialFuture(location.lat, location.lng);
        }
        throw "Invalid Location Type";
      });
    queryLocation.add(PlacewiseLocation(placename: "Cambridge"));
  }
  
  @override
  void dispose() {
    _forecastController.close();
  }
}