/// A simple API for accessing Ambee pollen data
library ambee_api;

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'keys.dart';

// Returns mock data if true to avoid API rate limits
const USE_MOCK_DATA = true;
const MOCK_DATA_PATH = "lib/apis/response_samples/ambee_sample.json";

/// API class used to make requests to Ambee
class AmbeeApi {
  /// The Ambee API key to use for requests
  final String apiKey = Keys.ambee;

  const AmbeeApi();

  /// Get current pollen data at a given latitude and longitude
  Future<PollenData> getPollenGeospatialCurrent(
      int latitude, int longitude) async {
    final params = <String, String>{
      "lat": latitude.toString(),
      "lng": longitude.toString(),
      "speciesRisk": "false"
    };
    var url =
        Uri.https("api.ambeedata.com", "/latest/pollen/by-lat-lng", params);
    return _getPollenInternal(url);
  }

  /// Get current pollen data at a given place, given by name
  Future<PollenData> getPollenPlacewiseCurrent(String placename) {
    var url = Uri.https("api.ambeedata.com", "/latest/pollen/by-place",
        {"place": placename, "speciesRisk": "false"});
    return _getPollenInternal(url);
  }

  /// Get future pollen data at a given latitude and longitude
  Future<PollenData> getPollenGeospatialFuture(
      int latitude, int longitude) async {
    final params = <String, String>{
      "lat": latitude.toString(),
      "lng": longitude.toString(),
      "speciesRisk": "false"
    };
    var url =
        Uri.https("api.ambeedata.com", "/forecast/pollen/by-lat-lng", params);
    return _getPollenInternal(url);
  }

  /// Get future pollen data at a given place, given by name
  Future<PollenData> getPollenFuturePlacewise(String placename) {
    var url = Uri.https("api.ambeedata.com", "/forecast/pollen/by-place",
        {"place": placename, "speciesRisk": "false"});
    return _getPollenInternal(url);
  }

  /// Makes a request to the Ambee API and returns the parsed response
  Future<PollenData> _getPollenInternal(Uri url) async {
    if (USE_MOCK_DATA)
      return PollenData.fromJson(
          jsonDecode(await rootBundle.loadString(MOCK_DATA_PATH)));
    var headers = {"x-api-key": apiKey, "Content-type": "application/json"};
    var response = await http.get(url, headers: headers);
    var json = jsonDecode(response.body);
    return PollenData.fromJson(json);
  }
}

/// A class represented the pollen data returned by the Ambee API
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

  /// Parses a JSON object into a [PollenData] object
  factory PollenData.fromJson(Map<String, dynamic> json) => PollenData(
        message: json["message"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

/// A class representing a single data point in the Ambee pollen data
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

  /// Parses a JSON object into a [Datum] object
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        count: Count.fromJson(json["Count"]),
        risk: Risk.fromJson(json["Risk"]),
        time: json.containsKey("time") ? json["time"] : null,
        updatedAt: json.containsKey("updatedAt")
            ? DateTime.parse(json["updatedAt"])
            : null,
      );
}

/// A class representing the pollen count for a given species in the Ambee data
class Count {
  int grassPollen;
  int treePollen;
  int weedPollen;

  Count({
    required this.grassPollen,
    required this.treePollen,
    required this.weedPollen,
  });

  /// Parses a JSON object into a [Count] object
  factory Count.fromJson(Map<String, dynamic> json) => Count(
        grassPollen: json["grass_pollen"],
        treePollen: json["tree_pollen"],
        weedPollen: json["weed_pollen"],
      );
}

/// A class representing the pollen risk for all species in the Ambee data
class Risk {
  Pollen grassPollen;
  Pollen treePollen;
  Pollen weedPollen;

  Risk({
    required this.grassPollen,
    required this.treePollen,
    required this.weedPollen,
  });

  /// Parses a JSON object into a [Risk] object
  factory Risk.fromJson(Map<String, dynamic> json) => Risk(
        grassPollen: pollenValues.map[json["grass_pollen"]]!,
        treePollen: pollenValues.map[json["tree_pollen"]]!,
        weedPollen: pollenValues.map[json["weed_pollen"]]!,
      );
}

/// An enum representing the pollen risk
enum Pollen { low, moderate, high, veryHigh }

/// A map of pollen values to enums
final pollenValues = EnumValues({
  "Low": Pollen.low,
  "Moderate": Pollen.moderate,
  "High": Pollen.high,
  "Very High": Pollen.veryHigh
});

/// A class used to parse enums from JSON
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
