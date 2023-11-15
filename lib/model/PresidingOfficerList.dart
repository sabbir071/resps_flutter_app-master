// To parse this JSON data, do
//
//     final presidingOfficerList = presidingOfficerListFromJson(jsonString);

import 'dart:convert';

List<PresidingOfficerList> presidingOfficerListFromJson(String str) => List<PresidingOfficerList>.from(json.decode(str).map((x) => PresidingOfficerList.fromJson(x)));

String presidingOfficerListToJson(List<PresidingOfficerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PresidingOfficerList {
    int? id;
    String? name;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    PresidingOfficerList({
         this.id,
         this.name,
         this.description,
         this.createdAt,
         this.updatedAt,
    });

    factory PresidingOfficerList.fromJson(Map<String, dynamic> json) => PresidingOfficerList(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
