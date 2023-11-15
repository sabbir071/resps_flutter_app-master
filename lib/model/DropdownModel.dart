// To parse this JSON data, do
//
//     final dropdownModel = dropdownModelFromMap(jsonString);

import 'dart:convert';

List<DropdownModel> dropdownModelFromMap(String str) =>
    List<DropdownModel>.from(
        json.decode(str).map((x) => DropdownModel.fromMap(x)));

String dropdownModelToMap(List<DropdownModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DropdownModel {
  int id;
  String name;

  DropdownModel({
    required this.id,
    required this.name,
  });

  factory DropdownModel.fromMap(Map<String, dynamic> json) => DropdownModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
