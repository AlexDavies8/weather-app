import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/apis/ambee_api.dart';
import 'package:weather_app/bloc/bloc.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/pollen_forecast.dart';
import 'package:path/path.dart' as Path;

const USE_MOCK_DATA = true;
final MOCK_DATA_PATH = "lib/apis/response_samples/ambee_sample.json";

class ForecastBloc extends Bloc {
  final StreamController _controller = StreamController<RequestLocation>();
  Sink<RequestLocation> get queryLocation => _controller.sink as Sink<RequestLocation>;
  
  late Stream<PollenForecast> forecast;

  late AmbeeApi ambeeApi;

  ForecastBloc() {
    ambeeApi = const AmbeeApi();
    forecast = _controller.stream
      .startWith(null)
      .asyncMap((location) async => PollenForecast(
        current: USE_MOCK_DATA ? PollenData.fromJson(await loadJsonFile(MOCK_DATA_PATH)) : await getCurrentData(location),
        forecast: USE_MOCK_DATA ? PollenData.fromJson(await loadJsonFile(MOCK_DATA_PATH)) : await getForecastData(location))
      );
    queryLocation.add(PlacewiseLocation(placename: "Cambridge"));
  }

  Future<PollenData> getCurrentData(RequestLocation location) {
    if (location is PlacewiseLocation) {
      return ambeeApi.getPollenPlacewiseCurrent(location.placename);
    } 
    if (location is LatLngLocation) {
      return ambeeApi.getPollenGeospatialCurrent(location.lat, location.lng);
    }
    throw "Invalid Location Type";
  }

  Future<PollenData> getForecastData(RequestLocation location) {
    if (location is PlacewiseLocation) {
      return ambeeApi.getPollenFuturePlacewise(location.placename);
    } 
    if (location is LatLngLocation) {
      return ambeeApi.getPollenGeospatialFuture(location.lat, location.lng);
    }
    throw "Invalid Location Type";
  }

  Future<Map<String, dynamic>> loadJsonFile(String path) async {
    final response = await rootBundle.loadString(path);
    Map<String, dynamic> json = jsonDecode(response);
    return Future(() => json);
  }
  
  @override
  void dispose() {
    _controller.close();
  }
}