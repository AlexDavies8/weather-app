/// Wrapper for [RequestLocation] that adds a display name
class Location {
  final String displayName;
  final RequestLocation requestLocation;

  Location({required this.displayName, required this.requestLocation});
}

/// Location Base Type
class RequestLocation {}

/// Represents a location specified by a placename
class PlacewiseLocation extends RequestLocation {
  final String placename;
  PlacewiseLocation({required this.placename});
}

/// Represents a location specified by a latitude and longitude
class LatLngLocation extends RequestLocation {
  final int lat;
  final int lng;
  LatLngLocation({required this.lat, required this.lng});

  factory LatLngLocation.fromCurrentLocation() =>
      LatLngLocation(lat: 52, lng: 1);
}
