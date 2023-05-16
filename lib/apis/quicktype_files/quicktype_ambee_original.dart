// To parse this JSON data, do
//
//     final pollenData = pollenDataFromJson(jsonString);

import 'dart:convert';

PollenData pollenDataFromJson(String str) => PollenData.fromJson(json.decode(str));

String pollenDataToJson(PollenData data) => json.encode(data.toJson());

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

    Map<String, dynamic> toJson() => {
        "message": message,
        "lat": lat,
        "lng": lng,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Count count;
    Risk risk;
    Species species;
    int time;
    DateTime updatedAt;

    Datum({
        required this.count,
        required this.risk,
        required this.species,
        required this.time,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        count: Count.fromJson(json["Count"]),
        risk: Risk.fromJson(json["Risk"]),
        species: Species.fromJson(json["Species"]),
        time: json["time"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "Count": count.toJson(),
        "Risk": risk.toJson(),
        "Species": species.toJson(),
        "time": time,
        "updatedAt": updatedAt.toIso8601String(),
    };
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

    Map<String, dynamic> toJson() => {
        "grass_pollen": grassPollen,
        "tree_pollen": treePollen,
        "weed_pollen": weedPollen,
    };
}

class Risk {
    Pollen grassPollen;
    TreePollen treePollen;
    Pollen weedPollen;

    Risk({
        required this.grassPollen,
        required this.treePollen,
        required this.weedPollen,
    });

    factory Risk.fromJson(Map<String, dynamic> json) => Risk(
        grassPollen: pollenValues.map[json["grass_pollen"]]!,
        treePollen: treePollenValues.map[json["tree_pollen"]]!,
        weedPollen: pollenValues.map[json["weed_pollen"]]!,
    );

    Map<String, dynamic> toJson() => {
        "grass_pollen": pollenValues.reverse[grassPollen],
        "tree_pollen": treePollenValues.reverse[treePollen],
        "weed_pollen": pollenValues.reverse[weedPollen],
    };
}

enum Pollen { moderate, low }

final pollenValues = EnumValues({
    "Low": Pollen.low,
    "Moderate": Pollen.moderate
});

enum TreePollen { high, moderate }

final treePollenValues = EnumValues({
    "High": TreePollen.high,
    "Moderate": TreePollen.moderate
});

class Species {
    Grass grass;
    int others;
    Tree tree;
    Weed weed;

    Species({
        required this.grass,
        required this.others,
        required this.tree,
        required this.weed,
    });

    factory Species.fromJson(Map<String, dynamic> json) => Species(
        grass: Grass.fromJson(json["Grass"]),
        others: json["Others"],
        tree: Tree.fromJson(json["Tree"]),
        weed: Weed.fromJson(json["Weed"]),
    );

    Map<String, dynamic> toJson() => {
        "Grass": grass.toJson(),
        "Others": others,
        "Tree": tree.toJson(),
        "Weed": weed.toJson(),
    };
}

class Grass {
    int grassPoaceae;

    Grass({
        required this.grassPoaceae,
    });

    factory Grass.fromJson(Map<String, dynamic> json) => Grass(
        grassPoaceae: json["Grass / Poaceae"],
    );

    Map<String, dynamic> toJson() => {
        "Grass / Poaceae": grassPoaceae,
    };
}

class Tree {
    int alder;
    int birch;
    int cypress;
    int elm;
    int hazel;
    int oak;
    int pine;
    int plane;
    int poplarCottonwood;

    Tree({
        required this.alder,
        required this.birch,
        required this.cypress,
        required this.elm,
        required this.hazel,
        required this.oak,
        required this.pine,
        required this.plane,
        required this.poplarCottonwood,
    });

    factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        alder: json["Alder"],
        birch: json["Birch"],
        cypress: json["Cypress"],
        elm: json["Elm"],
        hazel: json["Hazel"],
        oak: json["Oak"],
        pine: json["Pine"],
        plane: json["Plane"],
        poplarCottonwood: json["Poplar / Cottonwood"],
    );

    Map<String, dynamic> toJson() => {
        "Alder": alder,
        "Birch": birch,
        "Cypress": cypress,
        "Elm": elm,
        "Hazel": hazel,
        "Oak": oak,
        "Pine": pine,
        "Plane": plane,
        "Poplar / Cottonwood": poplarCottonwood,
    };
}

class Weed {
    int chenopod;
    int mugwort;
    int nettle;
    int ragweed;

    Weed({
        required this.chenopod,
        required this.mugwort,
        required this.nettle,
        required this.ragweed,
    });

    factory Weed.fromJson(Map<String, dynamic> json) => Weed(
        chenopod: json["Chenopod"],
        mugwort: json["Mugwort"],
        nettle: json["Nettle"],
        ragweed: json["Ragweed"],
    );

    Map<String, dynamic> toJson() => {
        "Chenopod": chenopod,
        "Mugwort": mugwort,
        "Nettle": nettle,
        "Ragweed": ragweed,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
