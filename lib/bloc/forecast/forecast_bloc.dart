import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/apis/ambee_api.dart';
import 'package:weather_app/bloc/forecast/forecast_event.dart';
import 'package:weather_app/bloc/forecast/forecast_state.dart';
import 'package:weather_app/models/pollen_forecast.dart';

import '../../models/location.dart';

/// The BLoC for the forecast page to manage the state of the forecast page
class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final AmbeeApi _ambeeApi = const AmbeeApi();

  ForecastBloc(super.initialState) {
    on<AddLocation>(_onAddLocation);
    on<RemoveLocation>(_onRemoveLocation);
    on<SelectLocation>(_onSelectLocation);
  }

  /// Add a location to the list of locations
  FutureOr<void> _onAddLocation(AddLocation event, emit) {
    return emit(ForecastState(
      locations: List.from(state.locations)..add(event.location),
      selectedLocation: state.selectedLocation,
      forecast: state.forecast
    ));
  }

  /// Remove a location from the list of locations
  FutureOr<void> _onRemoveLocation(RemoveLocation event, emit) async {
    final List<Location> locations = List.from(state.locations);
    locations.remove(event.location);

    if (state.selectedLocation == event.location) {
      emit(ForecastState(
        locations: locations,
        selectedLocation: locations.first,
        forecast: null
      ));
      return emit(ForecastState(
        locations: locations,
        selectedLocation: locations.first,
        forecast: await _getForecast(locations.first)
      ));
    }
    return emit(ForecastState(
      locations: locations,
      selectedLocation: state.selectedLocation,
      forecast: state.forecast
    ));
  }

  /// Select a location to be the currently selected location
  FutureOr<void> _onSelectLocation(SelectLocation event, emit) async {
    return emit(ForecastState(
      locations: state.locations,
      selectedLocation: event.location,
      forecast: await _getForecast(event.location)
    ));
  }


  /// Get all data for a given location
  Future<PollenForecast> _getForecast(Location location) async {
    return PollenForecast(
      current: await _getCurrentData(location.requestLocation),
      forecast: await _getForecastData(location.requestLocation)
    );
  }

  /// Get the current pollen data for a given location
  Future<PollenData> _getCurrentData(RequestLocation location) {
    if (location is PlacewiseLocation) {
      return _ambeeApi.getPollenPlacewiseCurrent(location.placename);
    } 
    if (location is LatLngLocation) {
      return _ambeeApi.getPollenGeospatialCurrent(location.lat, location.lng);
    }
    throw "Invalid Location Type";
  }

  /// Get the forecast pollen data for a given location
  Future<PollenData> _getForecastData(RequestLocation location) {
    if (location is PlacewiseLocation) {
      return _ambeeApi.getPollenFuturePlacewise(location.placename);
    } 
    if (location is LatLngLocation) {
      return _ambeeApi.getPollenGeospatialFuture(location.lat, location.lng);
    }
    throw "Invalid Location Type";
  }
}