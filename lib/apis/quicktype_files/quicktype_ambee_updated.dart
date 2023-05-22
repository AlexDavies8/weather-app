// Sample JSON data converted into a class using quicktype.io

import 'dart:convert';

PollenData pollenDataFromJson(String str) =>
    PollenData.fromJson(json.decode(str));

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
  int time;
  DateTime updatedAt;

  Datum({
    required this.count,
    required this.risk,
    required this.time,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        count: Count.fromJson(json["Count"]),
        risk: Risk.fromJson(json["Risk"]),
        time: json["time"],
        updatedAt: DateTime.parse(json["updatedAt"]),
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

enum Pollen { low, moderate, high, veryhigh }

final pollenValues = EnumValues({
  "Low": Pollen.low,
  "Moderate": Pollen.moderate,
  "High": Pollen.high,
  "Very High": Pollen.veryhigh
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
