import 'package:weather_app/apis/ambee_api.dart';

class PollenForecast {
  PollenData current;
  PollenData forecast;

  PollenForecast({required this.current, required this.forecast});
}