class Location {
  final String displayName;
  final RequestLocation requestLocation;

  Location({required this.displayName, required this.requestLocation});
}

class RequestLocation {}

class PlacewiseLocation extends RequestLocation {
  final String placename;
  PlacewiseLocation({required this.placename});
}

class LatLngLocation {
  final int lat;
  final int lng;
  LatLngLocation({required this.lat, required this.lng});
}