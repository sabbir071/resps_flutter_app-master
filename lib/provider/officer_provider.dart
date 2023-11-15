import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pollingstation/api/api.dart';
import 'package:pollingstation/api/api_service.dart';
import 'package:pollingstation/model/CoreCommitteeOfficerList.dart';
import 'package:pollingstation/model/PollingOfficerList.dart';
import 'package:pollingstation/model/PresidingOfficerList.dart';
import 'package:pollingstation/model/district_officer_list.dart';
import 'package:pollingstation/model/upazila_officer_list.dart';
import 'package:pollingstation/route.dart';


class OfficerProvider extends ApiService with ChangeNotifier {

  List<UnionWiseLocation> districtOfficerList = [];
  bool isOfficerListLoading = false;

  List<UpazilaOfficerList> upazilaOfficerList = [];
  bool isUpazilaOfficerListLoading = false;

  List<PresidingOfficerList> presidingOfficerList = [];
  bool isPresidingOfficerListLoading = false;

  List<PollingOfficerList> pollingOfficerList = [];
  bool isPollingOfficerListLoading = false;

  List<CoreCommitteeOfficerList> coreCommitteeList = [];
  bool isCoreCommitteeLoading = false;

  Future<void> getDistrictOfficerList(
      BuildContext context, {int? division, int? district}) async {
    isOfficerListLoading = true;
    notifyListeners();

    var query = {
      'type': 1.toString(),
      'division_id': division.toString(),
      'district_id': district.toString(),
    };

    var responses = await get(API.districtOfficer, queryParams: query);

    log(responses.body);

    if (responses.statusCode == 200) {
      districtOfficerList = unionWiseLocationFromJson(responses.body);

      if (districtOfficerList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('District officer list is empty for the selected criteria.'),
        ));
      } else {
        log(districtOfficerList.first.name!);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(responses.body)['message']),
      ));
    }

    isOfficerListLoading = false;
    notifyListeners();
  }

  Future<void> getUpazilaOfficerList(
      BuildContext context, {int? division, int? district, int? upazila}) async {
    isUpazilaOfficerListLoading = true;
    notifyListeners();

    var query = {
      'type': 2.toString(),
    'division_id': division.toString(),
    'district_id': district.toString(),
      'upazila_id': upazila.toString()
    };

    var responses = await get(API.upazilaOfficer, queryParams: query);

    log(responses.body);

    if (responses.statusCode == 200) {
      upazilaOfficerList = upazilaOfficerListFromJson(responses.body);
      if (upazilaOfficerList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Upazila officer list is empty for the selected criteria.'),
        ));
      } else {
        log(upazilaOfficerList.first.name!);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(responses.body)['message']),
      ));
    }

    isUpazilaOfficerListLoading = false;
    notifyListeners();
  }

  Future<void> getPresidingOfficerList(
      BuildContext context, {int? division = 0, int? district = 0, int? sub_district = 0, int? union = 0}) async {
    isPresidingOfficerListLoading = true;
    notifyListeners();

    var query = {
      "division_id": division.toString(),

      "district_id": district.toString(),

      "upazila_id": sub_district.toString(),

      "union_id": union.toString(),
    };

    var responses = await get(API.presidingOfficer, queryParams: query);

    log(responses.body);

    if (responses.statusCode == 200) {
      presidingOfficerList = presidingOfficerListFromJson(responses.body);

      if (presidingOfficerList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Category list is empty'),
        ));
      } else {
        log(presidingOfficerList.first.name!);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(responses.body)['message']),
      ));
    }

    isPresidingOfficerListLoading = false;
    notifyListeners();
  }

  Future<void> getPollingOfficerList(
      BuildContext context, {int? division = 0, int? district = 0, int? sub_district = 0, int? union = 0}) async {
    isPollingOfficerListLoading = true;
    notifyListeners();

    var query = {
      'type': 1.toString(),
      "division_id": division.toString(),
      "district_id": district.toString(),
      "upazila_id": sub_district.toString(),
      "center_id": union.toString(),
    };

    var responses = await get(API.pollingOfficer, queryParams: query);

    log(responses.body);

    if (responses.statusCode == 200) {
      pollingOfficerList = pollingOfficerListFromJson(responses.body);

        if (pollingOfficerList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Polling officer list is empty for the selected criteria.'),
          ));
        } else {
          log(pollingOfficerList.first.name!);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(responses.body)['message']),
        ));
      }

      isPollingOfficerListLoading = false;
      notifyListeners();
    }

  Future<void> getCoreCommitteeList(
      BuildContext context) async {
    isCoreCommitteeLoading = true;
    notifyListeners();

    var responses = await get(API.coreCommittee);

    log(responses.body);

    if (responses.statusCode == 200) {
      coreCommitteeList = coreCommitteeOfficerListFromJson(responses.body);
      log(coreCommitteeList.first.image!);
      isCoreCommitteeLoading = false;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(json.decode(responses.body)['message'])));
      isCoreCommitteeLoading = false;
      notifyListeners();
    }
  }

  void removeCurrentPage(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(RouteName.homeScreen);
  }

}
