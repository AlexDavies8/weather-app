import 'dart:async';

import '../models/location.dart';
import 'bloc.dart';

class LocationsBloc extends Bloc {
  final List<Location> _locations = [];

  final StreamController<LocationEvent> _locationController = StreamController();
  Sink<LocationEvent> get dispatch => _locationController.sink;
  late Stream<List<Location>> locations;

  LocationsBloc() {
    locations = _locationController.stream
      .asyncMap((event) {
        if (event is AddLocationEvent) {
          _locations.add(event.location);
        }
        if (event is RemoveLocationEvent) {
          _locations.remove(event.location);
        }
        return _locations;
      });
  }

  @override
  void dispose() {
    _locationController.close();
  }
}

class LocationEvent {}

class AddLocationEvent extends LocationEvent {
  final Location location;

  AddLocationEvent(this.location);
}

class RemoveLocationEvent extends LocationEvent {
  final Location location;

  RemoveLocationEvent(this.location);
}