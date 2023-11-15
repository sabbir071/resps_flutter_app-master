// To parse this JSON data, do
//
//     final centerModel = centerModelFromMap(jsonString);

import 'dart:convert';

CenterModel centerModelFromMap(String str) => CenterModel.fromMap(json.decode(str));

String centerModelToMap(CenterModel data) => json.encode(data.toMap());

class CenterModel {
  int? currentPage;
  List<Datum>? data;
  int? lastPage;

  CenterModel({
    this.currentPage,
    this.data,
    this.lastPage,
  });

  factory CenterModel.fromMap(Map<String, dynamic> json) => CenterModel(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "last_page": lastPage,
  };
}

class Datum {
  int? id;
  String? name;
  String? address;
  String? male;
  String? female;
  String? unionDistance;
  String? upazilaDistance;
  String? unDirtRoad;
  String? unPavedRoad;
  String? upDirtRoad;
  String? upPavedRoad;
  String? description;
  String? status;
  String? divisionId;
  String? districtId;
  String? upazilaId;
  String? unionId;
  String? latitude;
  String? longitude;
  AddressData? division;
  AddressData? district;
  AddressData? upazila;
  AddressData? union;
  AddressData? category;
  String? image;
  String? attachment;
  String? booth;
  String? estd;

  Datum(
      {this.id,
      this.name,
      this.address,
      this.male,
      this.female,
      this.unionDistance,
      this.upazilaDistance,
      this.unDirtRoad,
      this.unPavedRoad,
      this.upDirtRoad,
      this.upPavedRoad,
      this.description,
      this.status,
      this.divisionId,
      this.districtId,
      this.upazilaId,
      this.unionId,
      this.latitude,
      this.longitude,
      this.division,
      this.district,
      this.upazila,
      this.union,
        this.category,
      this.image,
      this.attachment,
      this.booth,
      this.estd
      });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      male: json["male"],
      female: json["female"],
      unionDistance: json["union_distance"],
      upazilaDistance: json["upazila_distance"],
      unDirtRoad: json["un_dirt_road"],
      unPavedRoad: json["un_paved_road"],
      upDirtRoad: json["up_dirt_road"],
      upPavedRoad: json["up_paved_road"],
      description: json["description"],
      status: json["status"],
      divisionId: json["division_id"],
      districtId: json["district_id"],
      upazilaId: json["upazila_id"],
      unionId: json["union_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      division: json["division"] == null
          ? null
          : AddressData.fromMap(json["division"]),
      district: json["district"] == null
          ? null
          : AddressData.fromMap(json["district"]),
      upazila: json["upazila"] == null ? null : AddressData.fromMap(json["upazila"]),
    union: json["union"] == null ? null : AddressData.fromMap(json["union"]),
      category: json["category"] == null ? null : AddressData.fromMap(json["category"]),
    image: json["image"],
    attachment: json["attachment"],
    booth: json["booth"],
      estd: json["estd"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "address": address,
    "male": male,
    "female": female,
    "union_distance": unionDistance,
    "upazila_distance": upazilaDistance,
    "un_dirt_road": unDirtRoad,
    "un_paved_road": unPavedRoad,
    "up_dirt_road": upDirtRoad,
    "up_paved_road": upPavedRoad,
    "description": description,
    "status": status,
    "division_id": divisionId,
    "district_id": districtId,
    "upazila_id": upazilaId,
    "union_id": unionId,
    "latitude": latitude,
    "longitude": longitude,
    "division": division?.toMap(),
    "district": district?.toMap(),
    "upazila": upazila?.toMap(),
    "union": union?.toMap(),
    "category": category?.toMap(),
    "image": image.toString(),
    "attachment": attachment.toString(),
    "booth": booth,
  "estd": estd,
  };


}


class AddressData {
  int? id;
  String? name;

  AddressData({
    this.id,
    this.name,
  });

  factory AddressData.fromMap(Map<String, dynamic> json) => AddressData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
