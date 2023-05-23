import 'package:weather_app/apis/ambee_api.dart';

/// A class representing the pollen forecast for a location
class PollenForecast {
  PollenData current;
  PollenData forecast;

  PollenForecast({required this.current, required this.forecast});
}
