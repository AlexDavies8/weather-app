import 'package:weather_app/models/location.dart';

abstract class ForecastEvent {
  const ForecastEvent();
}

class AddLocation extends ForecastEvent {
  final Location location;
  const AddLocation(this.location);
}

class RemoveLocation extends ForecastEvent {
  final Location location;
  const RemoveLocation(this.location);
}

class SelectLocation extends ForecastEvent {
  final Location location;
  const SelectLocation(this.location);
}