// To parse this JSON data, do
//
//     final pollenData = pollenDataFromJson(jsonString);

import 'dart:convert';

PollenData pollenDataFromJson(String str) => PollenData.fromJson(json.decode(str));

class PollenData {
    List<Datum> data;
    dynamic error;

    PollenData({
        required this.data,
        this.error,
    });

    factory PollenData.fromJson(Map<String, dynamic> json) => PollenData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
    );
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
}

class Location {
    String country;

    Location({
        required this.country,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        country: json["country"],
    );
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
}

class FluffyGrass {
    List<String> plants;

    FluffyGrass({
        required this.plants,
    });

    factory FluffyGrass.fromJson(Map<String, dynamic> json) => FluffyGrass(
        plants: List<String>.from(json["plants"].map((x) => x)),
    );
}
