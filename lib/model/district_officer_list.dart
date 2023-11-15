// To parse this JSON data, do
//
//     final unionWiseLocation = unionWiseLocationFromJson(jsonString);

import 'dart:convert';

List<UnionWiseLocation> unionWiseLocationFromJson(String str) => List<UnionWiseLocation>.from(json.decode(str).map((x) => UnionWiseLocation.fromJson(x)));

String unionWiseLocationToJson(List<UnionWiseLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnionWiseLocation {
  int id;
  String name;
  String latitude;
  String longitude;

  UnionWiseLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory UnionWiseLocation.fromJson(Map<String, dynamic> json) => UnionWiseLocation(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
  };
}
