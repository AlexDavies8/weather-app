// To parse this JSON data, do
//
//     final pollenData = pollenDataFromJson(jsonString);

import 'dart:convert';

PollenData pollenDataFromJson(String str) => PollenData.fromJson(json.decode(str));

String pollenDataToJson(PollenData data) => json.encode(data.toJson());

class PollenData {
    Metadata metadata;
    List<Datum> data;
    dynamic error;

    PollenData({
        required this.metadata,
        required this.data,
        this.error,
    });

    factory PollenData.fromJson(Map<String, dynamic> json) => PollenData(
        metadata: Metadata.fromJson(json["metadata"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class Datum {
    DateTime date;
    String indexId;
    String indexDisplayName;
    DatumTypes types;

    Datum({
        required this.date,
        required this.indexId,
        required this.indexDisplayName,
        required this.types,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: DateTime.parse(json["date"]),
        indexId: json["index_id"],
        indexDisplayName: json["index_display_name"],
        types: DatumTypes.fromJson(json["types"]),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "index_id": indexId,
        "index_display_name": indexDisplayName,
        "types": types.toJson(),
    };
}

class DatumTypes {
    PurpleGrass grass;
    PurpleGrass tree;
    PurpleGrass weed;

    DatumTypes({
        required this.grass,
        required this.tree,
        required this.weed,
    });

    factory DatumTypes.fromJson(Map<String, dynamic> json) => DatumTypes(
        grass: PurpleGrass.fromJson(json["grass"]),
        tree: PurpleGrass.fromJson(json["tree"]),
        weed: PurpleGrass.fromJson(json["weed"]),
    );

    Map<String, dynamic> toJson() => {
        "grass": grass.toJson(),
        "tree": tree.toJson(),
        "weed": weed.toJson(),
    };
}

class PurpleGrass {
    String displayName;
    bool inSeason;
    bool dataAvailable;
    Index index;

    PurpleGrass({
        required this.displayName,
        required this.inSeason,
        required this.dataAvailable,
        required this.index,
    });

    factory PurpleGrass.fromJson(Map<String, dynamic> json) => PurpleGrass(
        displayName: json["display_name"],
        inSeason: json["in_season"],
        dataAvailable: json["data_available"],
        index: Index.fromJson(json["index"]),
    );

    Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "in_season": inSeason,
        "data_available": dataAvailable,
        "index": index.toJson(),
    };
}

class Index {
    int? value;
    String? category;
    String? color;

    Index({
        this.value,
        this.category,
        this.color,
    });

    factory Index.fromJson(Map<String, dynamic> json) => Index(
        value: json["value"],
        category: json["category"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "category": category,
        "color": color,
    };
}

class Metadata {
    DateTime startDate;
    DateTime endDate;
    Location location;
    MetadataTypes types;

    Metadata({
        required this.startDate,
        required this.endDate,
        required this.location,
        required this.types,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        location: Location.fromJson(json["location"]),
        types: MetadataTypes.fromJson(json["types"]),
    );

    Map<String, dynamic> toJson() => {
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "location": location.toJson(),
        "types": types.toJson(),
    };
}

class Location {
    String country;

    Location({
        required this.country,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
    };
}

class MetadataTypes {
    FluffyGrass grass;
    FluffyGrass tree;
    FluffyGrass weed;

    MetadataTypes({
        required this.grass,
        required this.tree,
        required this.weed,
    });

    factory MetadataTypes.fromJson(Map<String, dynamic> json) => MetadataTypes(
        grass: FluffyGrass.fromJson(json["grass"]),
        tree: FluffyGrass.fromJson(json["tree"]),
        weed: FluffyGrass.fromJson(json["weed"]),
    );

    Map<String, dynamic> toJson() => {
        "grass": grass.toJson(),
        "tree": tree.toJson(),
        "weed": weed.toJson(),
    };
}

class FluffyGrass {
    List<String> plants;

    FluffyGrass({
        required this.plants,
    });

    factory FluffyGrass.fromJson(Map<String, dynamic> json) => FluffyGrass(
        plants: List<String>.from(json["plants"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "plants": List<dynamic>.from(plants.map((x) => x)),
    };
}
