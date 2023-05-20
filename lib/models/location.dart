/// Wrapper for [RequestLocation] that add's a display name
class Location {
  final String displayName;
  final RequestLocation requestLocation;

  Location({required this.displayName, required this.requestLocation});
}

/// Location Base Type
class RequestLocation {}

/// Specified by a placename
class PlacewiseLocation extends RequestLocation {
  final String placename;
  PlacewiseLocation({required this.placename});
}

/// Specified by a latitude and longitude
class LatLngLocation extends RequestLocation {
  final int lat;
  final int lng;
  LatLngLocation({required this.lat, required this.lng});

  factory LatLngLocation.fromCurrentLocation() => LatLngLocation(lat: 52, lng: 1);
}