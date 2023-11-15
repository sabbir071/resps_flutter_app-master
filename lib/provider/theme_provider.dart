import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'light';

  double currentValue = 1.0;

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  List<double> fontValue = <double>[.80, 1.0, 1.50];

  List<String> fontName = <String>['Small', 'Medium', 'Large'];

  changeValue(double data) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('font', data);
    currentValue = data;
    notifyListeners();
  }

  changeTheme(String theme) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _prefs.getString('theme') ?? 'system';
    currentValue = _prefs.getDouble('font') ?? 1.0;
    notifyListeners();
  }

  // navigator

  int screenIndex = 0;

  int get fetchCurrentScreenIndex => screenIndex;

  void updateScreenIndex(int newIndex) {
    // function to update the current screenIndex
    screenIndex = newIndex;
    notifyListeners();
  }

  // navigate using your logic
  Future<void> splashInit(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.homeScreen, (route) => false);
    });
  }

/*  Future<void> initLocation() async {
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    LocationData _locationData = await _location.getLocation();
    currentLatLang = LatLng(_locationData.latitude!, _locationData.longitude!);

    await _sharedPreferences.setDouble("lat", _locationData.latitude!);
    await _sharedPreferences.setDouble("lon", _locationData.longitude!);
  }*/
}
