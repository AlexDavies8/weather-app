/// A simple API for accessing Breezometer pollen data
library breezometer_api;

import 'dart:convert';

import 'package:http/http.dart' as http;

/// API class used to make requests to Breezometer
class BreezometerAPI {
  /// The Breezometer API key to use for requests
  final String apiKey = "e27c63872fe7497188743c4c5fe9c26d";

  const BreezometerAPI();

  // Get pollen data at a given latitude and longitude
  Future<PollenData> getPollenGeospatial(int latitude, int longitude, [features]) async {
    var url = Uri.https(
        "api.breezometer.com",
        "/pollen/v2/forecast/daily",
        {
          "lat": latitude,
          "lon": longitude,
          "key": apiKey,
          "features": features,
          "days": 5
        });
    return _getPollenInternal(url);
  }

  // /// Get pollen data at a given place, given by name
  // Future<PollenData> getPollenPlacewise(String placename) {
  //   var url = Uri.https("api.ambeedata.com", "/forecast/pollen/by-place", {"place": placename});
  //   return _getPollenInternal(url);
  // }

  Future<PollenData> _getPollenInternal(Uri url) async {
    // var headers = {"x-api-key": apiKey, "Content-type": "application/json"};
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return PollenData.fromJson(json['data']);
  }
}

/// Complete Pollen Data
class PollenData {
  final int time;
  final int latitude;
  final int longitude;
  final PollenCount count;
  final PollenRisk risk;

  PollenData(this.time, this.latitude, this.longitude, this.count, this.risk);

  PollenData.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        latitude = json['lat'],
        longitude = json['lng'],
        count = PollenCount.fromJson(json['Count']),
        risk = PollenRisk.fromJson(json['Risk']);
}

/// Pollen count data for classes of flora
class PollenCount {
  final int grass;
  final int tree;
  final int weed;

  PollenCount(this.grass, this.tree, this.weed);

  PollenCount.fromJson(Map<String, dynamic> json)
      : grass = json['grass'],
        tree = json['tree'],
        weed = json['weed'];
}

/// Pollen risk level data for classes of flora
class PollenRisk {
  final RiskLevel grass;
  final RiskLevel tree;
  final RiskLevel weed;

  PollenRisk(this.grass, this.tree, this.weed);

  PollenRisk.fromJson(Map<String, dynamic> json)
      : grass = parseRiskLevel(json['grass']),
        tree = parseRiskLevel(json['tree']),
        weed = parseRiskLevel(json['weed']);
}

enum RiskLevel { low, medium, high }

RiskLevel parseRiskLevel(String string) {
  switch (string.toLowerCase()) {
    case 'low':
      return RiskLevel.low;
    case 'medium':
      return RiskLevel.medium;
    case 'high':
      return RiskLevel.high;
  }
  throw Error();
}
