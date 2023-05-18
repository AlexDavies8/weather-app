/// A simple API for accessing Ambee pollen data
library ambee_api;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'keys.dart';

/// API class used to make requests to Ambee
class AmbeeApi {
  /// The Ambee API key to use for requests
  final String apiKey = Keys.ambee;

  const AmbeeApi();

  /// Get pollen data at a given latitude and longitude
  Future<PollenData> getPollenGeospatialCurrent(
      int latitude, int longitude) async {
    var url = Uri.https("api.ambeedata.com", "/latest/pollen/by-lat-lng",
        {"lat": latitude, "lng": longitude});
    return _getPollenInternal(url);
  }

  /// Get pollen data at a given place, given by name
  Future<PollenData> getPollenPlacewiseCurrent(String placename) {
    var url = Uri.https(
        "api.ambeedata.com", "/latest/pollen/by-place", {"place": placename});
    return _getPollenInternal(url);
  }

  /// Get pollen data for the future at a given latitude and longitude
  Future<PollenData> getPollenGeospatialFuture(
      int latitude, int longitude) async {
    var url = Uri.https("api.ambeedata.com", "/forecast/pollen/by-lat-lng",
        {"lat": latitude, "lng": longitude});
    return _getPollenInternal(url);
  }

  /// Get pollen data for the future at a given place, given by name
  Future<PollenData> getPollenFuturePlacewise(String placename) {
    var url = Uri.https(
        "api.ambeedata.com", "/forecast/pollen/by-place", {"place": placename});
    return _getPollenInternal(url);
  }

  Future<PollenData> _getPollenInternal(Uri url) async {
    var headers = {"x-api-key": apiKey, "Content-type": "application/json"};
    var response = await http.get(url, headers: headers);
    var json = jsonDecode(response.body);
    return PollenData.fromJson(json);
  }
}

class PollenData {
  String message;
  double lat;
  double lng;
  List<Datum> data;

  PollenData({
    required this.message,
    required this.lat,
    required this.lng,
    required this.data,
  });

  factory PollenData.fromJson(Map<String, dynamic> json) => PollenData(
        message: json["message"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Count count;
  Risk risk;
  int? time;
  DateTime? updatedAt;

  Datum({
    required this.count,
    required this.risk,
    this.time,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        count: Count.fromJson(json["Count"]),
        risk: Risk.fromJson(json["Risk"]),
        time: json.containsKey("time") ? json["time"] : null,
        updatedAt: json.containsKey("updatedAt") ? DateTime.parse(json["updatedAt"]) : null,
      );
}

class Count {
  int grassPollen;
  int treePollen;
  int weedPollen;

  Count({
    required this.grassPollen,
    required this.treePollen,
    required this.weedPollen,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        grassPollen: json["grass_pollen"],
        treePollen: json["tree_pollen"],
        weedPollen: json["weed_pollen"],
      );
}

class Risk {
  Pollen grassPollen;
  Pollen treePollen;
  Pollen weedPollen;

  Risk({
    required this.grassPollen,
    required this.treePollen,
    required this.weedPollen,
  });

  factory Risk.fromJson(Map<String, dynamic> json) => Risk(
        grassPollen: pollenValues.map[json["grass_pollen"]]!,
        treePollen: pollenValues.map[json["tree_pollen"]]!,
        weedPollen: pollenValues.map[json["weed_pollen"]]!,
      );
}

enum Pollen { low, moderate, high, veryHigh }

final pollenValues = EnumValues({
  "Low": Pollen.low,
  "Moderate": Pollen.moderate,
  "High": Pollen.high,
  "Very High": Pollen.veryHigh
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
