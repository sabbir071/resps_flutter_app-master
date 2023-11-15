// To parse this JSON data, do
//
//     final coreCommitteeOfficerList = coreCommitteeOfficerListFromJson(jsonString);

import 'dart:convert';

List<CoreCommitteeOfficerList> coreCommitteeOfficerListFromJson(String str) => List<CoreCommitteeOfficerList>.from(json.decode(str).map((x) => CoreCommitteeOfficerList.fromJson(x)));

String coreCommitteeOfficerListToJson(List<CoreCommitteeOfficerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoreCommitteeOfficerList {
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
    String? createdAt;
    String? updatedAt;
    District? division;
    District? district;
    District? upazila;

    CoreCommitteeOfficerList({
        required this.id,
         this.name,
         this.designation,
         this.phone,
         required this.image,
         this.status,
         this.type,
         this.divisionId,
         this.districtId,
         this.upazilaId,
         this.priority,
         this.createdAt,
         this.updatedAt,
         this.division,
         this.district,
         this.upazila,
    });

    factory CoreCommitteeOfficerList.fromJson(Map<String, dynamic> json) => CoreCommitteeOfficerList(
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        division: District.fromJson(json["division"]),
        district: District.fromJson(json["district"]),
        upazila: District.fromJson(json["upazila"]),
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "division": division?.toJson(),
        "district": district?.toJson(),
        "upazila": upazila?.toJson(),
    };
}

class District {
    int id;
    String name;
    String bnName;

    District({
        required this.id,
        required this.name,
        required this.bnName,
    });

    factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        bnName: json["bn_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bn_name": bnName,
    };
}
