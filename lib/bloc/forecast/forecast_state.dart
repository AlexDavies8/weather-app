import 'package:weather_app/models/pollen_forecast.dart';

import '../../models/location.dart';

/// A class representing the state of the forecast page
class ForecastState {
  final List<Location> locations;
  Location? selectedLocation;
  PollenForecast? forecast;

  ForecastState({
    required this.locations,
    required this.selectedLocation,
    required this.forecast
  });

  factory ForecastState.empty() => ForecastState(
    locations: [],
    selectedLocation: null,
    forecast: null
  );
}