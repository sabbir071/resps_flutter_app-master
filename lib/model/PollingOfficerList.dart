// To parse this JSON data, do
//
//     final pollingOfficerList = pollingOfficerListFromJson(jsonString);

import 'dart:convert';

List<PollingOfficerList> pollingOfficerListFromJson(String str) => List<PollingOfficerList>.from(json.decode(str).map((x) => PollingOfficerList.fromJson(x)));

String pollingOfficerListToJson(List<PollingOfficerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PollingOfficerList {
    int id;
    String? divisionId;
    String? districtId;
    String? upazilaId;
    String? unionId;
    String? centerId;
    String? name;
    String? phone;
    String? type;
    String? email;
    String? status;
    String? designation;
    String? photo;
    String? priority;
    DateTime? createdAt;
    DateTime? updatedAt;
    District? division;
    District? district;
    District? upazila;
    District? union;
    Center? center;

    PollingOfficerList({
        required this.id,
         this.divisionId,
         this.districtId,
         this.upazilaId,
         this.unionId,
         this.centerId,
         this.name,
         this.phone,
         this.type,
         this.email,
         this.status,
         this.designation,
         this.photo,
         this.priority,
         this.createdAt,
         this.updatedAt,
         this.division,
         this.district,
         this.upazila,
         this.union,
         this.center,
    });

    factory PollingOfficerList.fromJson(Map<String, dynamic> json) => PollingOfficerList(
        id: json["id"],
        divisionId: json["division_id"],
        districtId: json["district_id"],
        upazilaId: json["upazila_id"],
        unionId: json["union_id"],
        centerId: json["center_id"],
        name: json["name"],
        phone: json["phone"],
        type: json["type"],
        email: json["email"],
        status: json["status"],
        designation: json["designation"],
        photo: json["photo"],
        priority: json["priority"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        division: District.fromJson(json["division"]),
        district: District.fromJson(json["district"]),
        upazila: District.fromJson(json["upazila"]),
        union: District.fromJson(json["union"]),
        center: Center.fromJson(json["center"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "division_id": divisionId,
        "district_id": districtId,
        "upazila_id": upazilaId,
        "union_id": unionId,
        "center_id": centerId,
        "name": name,
        "phone": phone,
        "type": type,
        "email": email,
        "status": status,
        "designation": designation,
        "photo": photo,
        "priority": priority,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "division": division?.toJson(),
        "district": district?.toJson(),
        "upazila": upazila?.toJson(),
        "union": union?.toJson(),
        "center": center?.toJson(),
    };
}

class Center {
    int id;
    String name;

    Center({
        required this.id,
        required this.name,
    });

    factory Center.fromJson(Map<String, dynamic> json) => Center(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
