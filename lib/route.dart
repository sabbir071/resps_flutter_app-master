import 'package:flutter/material.dart';
import 'package:pollingstation/model/dropdown_id.dart';
import 'package:pollingstation/ui/screen/about/about_up_officer_screen.dart';
import 'package:pollingstation/ui/screen/home/home_screen.dart';
import 'package:pollingstation/ui/screen/home/landing_screen.dart';
import 'package:pollingstation/ui/screen/officer/district_officer_list_screen.dart';
import 'package:pollingstation/ui/screen/officer/polling_officer_list_screen.dart';
import 'package:pollingstation/ui/screen/officer/presiding_officer_list_screen.dart';
import 'package:pollingstation/ui/screen/officer/upazila_officer_list_screen.dart';
import 'package:pollingstation/ui/screen/search/search_screen.dart';
import 'package:pollingstation/ui/screen/splash/splash_screen.dart';
import 'package:pollingstation/ui/screen/stationdetails/image_view_screen.dart';
import 'package:pollingstation/ui/screen/stationdetails/station_details_screen.dart';

import 'model/center_model.dart';

class RouteName {
  static String splashScreen = "/splash_screen";
  static String landingScreen= '/landing_screen';
  static String upazilaOfficer= '/upazila_officer';
  static String stationDetailsScree='/station_details_screen';
  static String searchScreen='/search_screen';
  static String homeScreen='/home_screen';
  static String imageView="/image_view_full";
  static String districtOfficerListScreen ="/district_officer_list_screen";
  static String upazilaOfficerListScreen ="/upazila_officer_list_screen";
  static String presidingOfficerListScreen ="/presiding_officer_list_screen";
  static String pollingOfficerListScreen ="/polling_officer_list_screen";

}


Map<String, WidgetBuilder> routes({Object? arg}) =>
    {
      RouteName.splashScreen: (context) => const SplashScreen(),
      RouteName.landingScreen: (context) => const LandingScreen(),
      RouteName.upazilaOfficer: (context) => const AboutUPOfficerScreen(),
      RouteName.districtOfficerListScreen: (context) =>  DistrictOfficerListScreen(data: arg as DropDownID, ),
      RouteName.upazilaOfficerListScreen: (context) =>  UpazilaOfficerListScreen(data: arg as DropDownID,),
      RouteName.presidingOfficerListScreen: (context) =>  PresidingOfficerListScreen(),
      RouteName.pollingOfficerListScreen: (context) =>  PollingOfficerListScreen(),
      RouteName.stationDetailsScree: (context) =>  StationDetailsScreen(data: arg as Datum,),
      RouteName.searchScreen: (context)=> SearchScreen(),
      RouteName.homeScreen: (context) => HomeScreen(),
      RouteName.imageView: (context) => ImageViewScreen(image: arg.toString())

    };

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  final Function? builder =
  routes(arg: routeSettings.arguments)[routeSettings.name];
  if (builder != null) {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start off-screen
        const end = Offset.zero; // End at the original position
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  } else {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Page not found for ${routeSettings.name}'),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start off-screen
        const end = Offset.zero; // End at the original position
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}