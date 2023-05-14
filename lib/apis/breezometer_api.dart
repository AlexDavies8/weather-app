/// A simple API for accessing Breezometer pollen data
library breezometer_api;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'keys.dart';

enum PollenType { grass, tree, weed }

/// API class used to make requests to Breezometer
class BreezometerAPI {
  /// The Breezometer API key to use for requests
  final String apiKey = Keys.breezometer;

  const BreezometerAPI();

  // Get pollen data at a given latitude and longitude
  Future<PollenData> getPollenGeospatial(int latitude, int longitude,
      [features]) async {
    var url = Uri.https("api.breezometer.com", "/pollen/v2/forecast/daily", {
      "lat": latitude,
      "lon": longitude,
      "key": apiKey,
      "features": features,
      "days": 5
    });
    return _getPollenInternal(url);
  }

  Future<PollenData> getHeatmapTiles(
    int zoom,
    int x,
    int y,
    PollenType type,
  ) async {
    var url = Uri.https("tiles.breezometer.com",
        "/v1/pollen/$type/forecast/daily/$zoom/$x/$y.png", {
      "key": apiKey,
    });
    return _getPollenInternal(url); // TODO: fix this
  }

  Future<PollenData> _getPollenInternal(Uri url) async {
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return PollenData.fromJson(json);
  }
}

class PollenData {
  List<Day> data;
  dynamic error;

  PollenData({
    required this.data,
    this.error,
  });

  factory PollenData.fromJson(Map<String, dynamic> json) => PollenData(
        data: List<Day>.from(json["data"].map((x) => Day.fromJson(x))),
        error: json["error"],
      );
}

class Day {
  DateTime date;
  Map grass;
  Map tree;
  Map weed;

  Day({
    required this.date,
    required this.grass,
    required this.tree,
    required this.weed,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        date: DateTime.parse(json["date"]),
        grass: {
          "value": json["types"]["grass"]["index"]["value"],
          "category": json["types"]["grass"]["index"]["category"],
          "color": json["types"]["grass"]["index"]["color"],
        },
        tree: {
          "value": json["types"]["tree"]["index"]["value"],
          "category": json["types"]["tree"]["index"]["category"],
          "color": json["types"]["tree"]["index"]["color"],
        },
        weed: {
          "value": json["types"]["weed"]["index"]["value"],
          "category": json["types"]["weed"]["index"]["category"],
          "color": json["types"]["weed"]["index"]["color"],
        },
      );
}
