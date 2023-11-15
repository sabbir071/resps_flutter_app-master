import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pollingstation/api/api.dart';
import 'package:pollingstation/api/api_service.dart';
import 'package:pollingstation/model/DropdownModel.dart';
import 'package:pollingstation/model/district_officer_list.dart';

import '../model/center_model.dart';

class AppProvider extends ApiService with ChangeNotifier {
  AppProvider() {
    getDivisionData();

  }

  List<UnionWiseLocation>? _districtOfficerList;

  List<UnionWiseLocation>? get districtOfficerList => _districtOfficerList;

  bool isDivisionLoading = true;
  bool isDistrictLoading = false;
  bool isUpazilaLoading = false;
  bool isUnionLoading = false;
  bool isOfficerListLoading = false;

  List<DropdownModel> _divisionList = [];
  List<DropdownModel> _districtList = [];
  List<DropdownModel> _upazilaList = [];
  List<DropdownModel> _unionList = [];

  List<DropdownModel> get divisionList => _divisionList;

  List<DropdownModel> get districtList => _districtList;

  List<DropdownModel> get upazilaList => _upazilaList;

  List<DropdownModel> get unionList => _unionList;

  DropdownModel? selectedDivision;
  DropdownModel? selectedDistrict;
  DropdownModel? selectedUpazila;
  DropdownModel? selectedUnion;

  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);


  int lastPage = 2;

  void getDivisionData() async {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    var response = await get(API.division);
    _divisionList.add(DropdownModel(id: 0, name: "Select Division"));
    if (response.statusCode == 200) {
      _divisionList.addAll(dropdownModelFromMap(response.body));
      selectedDivision = _divisionList.first;
      isDivisionLoading = false;
      notifyListeners();
    } else {
      log(response.body);
      isDivisionLoading = false;
      notifyListeners();
    }
    _districtList.add(DropdownModel(id: 0, name: "Select District"));
    selectedDistrict = _districtList.first;

    _upazilaList.add(DropdownModel(id: 0, name: "Select Upazila"));
    selectedUpazila = _upazilaList.first;

    _unionList.add(DropdownModel(id: 0, name: "Select Union"));
    selectedUnion = _unionList.first;
    notifyListeners();

  }

  void getDistrictData(int divisionId) async {
    isDistrictLoading = true;
    selectedDistrict = null;
    _districtList.clear();
    notifyListeners();

    var query = {"division_id": divisionId.toString()};

    var response = await get(API.district, queryParams: query);
    _districtList.add(DropdownModel(id: 0, name: "Select District"));
    if (response.statusCode == 200) {
      _districtList.addAll(dropdownModelFromMap(response.body));
      selectedDistrict = _districtList.first;
      isDistrictLoading = false;
      notifyListeners();
    } else {
      log(response.body);
      isDistrictLoading = false;
      notifyListeners();
    }
  }

  void getUpazilaData(int districtId) async {
    isUpazilaLoading = true;
    selectedUpazila = null;
    _upazilaList.clear();
    notifyListeners();

    var query = {"district_id": districtId.toString()};
    var response = await get(API.upazila, queryParams: query);
    _upazilaList.add(DropdownModel(id: 0, name: "Select Upazila"));
    if (response.statusCode == 200) {
      _upazilaList.addAll(dropdownModelFromMap(response.body));
      selectedUpazila = _upazilaList.first;
      isUpazilaLoading = false;
      notifyListeners();
    } else {
      log(response.body);
      isUpazilaLoading = false;
      notifyListeners();
    }
  }

  void getUnionData(int upazilaId) async {
    isUnionLoading = true;
    selectedUnion = null;
    _unionList.clear();
    notifyListeners();
    var query = {"upazila_id": upazilaId.toString()};
    var response = await get(API.union, queryParams: query);
    _unionList.add(DropdownModel(id: 0, name: "Select Union"));
    if (response.statusCode == 200) {
      _unionList.addAll(dropdownModelFromMap(response.body));
      selectedUnion = _unionList.first;
      isUnionLoading = false;
      notifyListeners();
    } else {
      log(response.body);
      isUnionLoading = false;
      notifyListeners();
    }
  }

  void setSelectDivision(DropdownModel model) {
    selectedDivision = model;
    getDistrictData(model.id);
    if (_upazilaList.length > 1) {
      getUpazilaData(0);
    }
    if (_unionList.length > 1) {
      getUnionData(0);
    }
    notifyListeners();
  }

  void setSelectDistrict(DropdownModel model) {
    selectedDistrict = model;
    getUpazilaData(model.id);
    if (_unionList.length > 1) {
      getUnionData(0);
    }
    notifyListeners();
  }

  void setSelectedUpazila(DropdownModel model) {
    selectedUpazila = model;
    getUnionData(model.id);
    notifyListeners();
  }

  void setSelectUnion(DropdownModel model) {
    selectedUnion = model;
    // todo get the center list
    notifyListeners();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      var query = {
        "page": pageKey.toString(),
        if (selectedDivision?.id != 0)
          "division_id": selectedDivision?.id.toString(),
        if (selectedDistrict?.id != 0)
          "district_id": selectedDistrict?.id.toString(),
        if (selectedUpazila?.id != 0)
          "upazila_id": selectedUpazila?.id.toString(),
        if (selectedUnion?.id != 0) "union_id": selectedUnion?.id.toString(),
      };
      var response = await get(API.center, queryParams: query);


      var data = centerModelFromMap(response.body);
      lastPage = data.lastPage!;

      var newItems = data.data;

      final isLastPage = pageKey == lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(newItems!);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems!, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> getDistrictOfficerList(
      BuildContext context) async {
    isOfficerListLoading = true;
    notifyListeners();

 /*   var query = {
      'type': 1.toString(),
    };*/

    var responses = await get(API.districtOfficer);

    log(responses.body);

    if (responses.statusCode == 200) {
      _districtOfficerList = unionWiseLocationFromJson(responses.body);
      log(_districtOfficerList!.first.name);
      isOfficerListLoading = false;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(json.decode(responses.body)['message'])));
      isOfficerListLoading = false;
      notifyListeners();
    }
  }

  void disposeData() {
    _divisionList.add(DropdownModel(id: 0, name: "Select Division"));
    selectedDivision = _divisionList.first;

    _districtList.add(DropdownModel(id: 0, name: "Select District"));
    selectedDistrict = _districtList.first;

    _upazilaList.add(DropdownModel(id: 0, name: "Select Upazila"));
    selectedUpazila = _upazilaList.first;

    _unionList.add(DropdownModel(id: 0, name: "Select Union"));
    selectedUnion = _unionList.first;

    notifyListeners();

  }

}
