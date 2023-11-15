// To parse this JSON data, do
//
//     final upazilaOfficerList = upazilaOfficerListFromJson(jsonString);

import 'dart:convert';

List<UpazilaOfficerList> upazilaOfficerListFromJson(String str) => List<UpazilaOfficerList>.from(json.decode(str).map((x) => UpazilaOfficerList.fromJson(x)));

String upazilaOfficerListToJson(List<UpazilaOfficerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpazilaOfficerList {
    int id;
    String? name;
    String? designation;
    String? phone;
    String? image;
    String? status;
    String? type;
    String? divisionId;
    String? districtId;
    String? upazilaId;
    String? priority;
    DateTime? createdAt;
    DateTime? updatedAt;

    UpazilaOfficerList({
        required this.id,
         this.name,
         this.designation,
         this.phone,
         this.image,
         this.status,
         this.type,
         this.divisionId,
         this.districtId,
         this.upazilaId,
         this.priority,
         this.createdAt,
         this.updatedAt,
    });

    factory UpazilaOfficerList.fromJson(Map<String, dynamic> json) => UpazilaOfficerList(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        phone: json["phone"],
        image: json["image"],
        status: json["status"],
        type: json["type"],
        divisionId: json["division_id"],
        districtId: json["district_id"],
        upazilaId: json["upazila_id"],
        priority: json["priority"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "designation": designation,
        "phone": phone,
        "image": image,
        "status": status,
        "type": type,
        "division_id": divisionId,
        "district_id": districtId,
        "upazila_id": upazilaId,
        "priority": priority,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
