import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pollingstation/config/constant.dart';
import 'package:pollingstation/model/dropdown_id.dart';
import 'package:pollingstation/route.dart';
import 'package:pollingstation/ui/screen/home/widget/OfficerItemCard.dart';
import 'package:pollingstation/ui/screen/home/widget/custom_drawer.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../model/DropdownModel.dart';
import '../../../model/center_model.dart';
import '../../../provider/app_provider.dart';
import '../../widget/custom_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DropDownID downID = new DropDownID(division: 0, district: 0, subDistrict: 0);
   // Provider.of<AppProvider>(context, listen: false).getDistrictOfficerList(context);
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
          'Home',
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomSimpleText(
                  text: 'শাজাহানপুর উপজেলা প্রকল্প সমূহ',
                  fontSize: 22,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: MediaQuery.of(context).size.width / 2 - 13,
                    child: provider.isDivisionLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomDropDown(
                            fieldTitle: "Select Division",
                            spinnerItemList: provider.divisionList,
                            selectedItem: provider.selectedDivision ??
                                provider.divisionList.first,
                            onChanged: (DropdownModel model) {
                              provider.setSelectDivision(model);
                              downID.division = model.id;
                            },
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width / 2 - 13,
                    child: provider.isDistrictLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomDropDown(
                            fieldTitle: "Select District",
                            spinnerItemList: provider.districtList,
                            selectedItem: provider.selectedDistrict,
                            onChanged: (DropdownModel model) {
                              provider.setSelectDistrict(model);
                              provider.pagingController.refresh();
                              downID.district = model.id;
                            },
                          ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: MediaQuery.of(context).size.width / 2 - 13,
                    child: provider.isUpazilaLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomDropDown(
                            fieldTitle: "Select Upazila",
                            spinnerItemList: provider.upazilaList,
                            selectedItem: provider.selectedUpazila,
                            onChanged: (DropdownModel model) {
                              provider.pagingController.refresh();
                              provider.setSelectedUpazila(model);
                              downID.subDistrict = model.id;
                            },
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width / 2 - 13,
                    child: provider.isUnionLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomDropDown(
                            fieldTitle: "Select Union",
                            spinnerItemList: provider.unionList,
                            selectedItem: provider.selectedUnion,
                            onChanged: (DropdownModel model) {
                              provider.setSelectUnion(model);
                              provider.pagingController.refresh();
                            },
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),


               InkWell(
                  child: OfficerItemCard(
                    personName: "উপজেলার সংশ্লিষ্ট প্রকল্পের ম্যাপ",
                    className: 'ম্যাপ দেখতে কার্ডটিতে ক্লিক করুন',
                    image: sub_district,
                  ),

                   onTap: () async {

                   }

               ),


                 /*    onTap: () async {
                     // Check if Google Maps is available
                     final isGoogleMapsAvailable = await MapLauncher.isMapAvailable(MapType.google);

                     if (isGoogleMapsAvailable != null && isGoogleMapsAvailable) {
                       try {
                         for (var officer in provider.districtOfficerList!) {
                           await MapLauncher.showMarker(
                             mapType: MapType.google,
                             coords: Coords(
                               double.parse(officer.latitude),
                               double.parse(officer.longitude),
                             ),
                             title: officer.name ?? '',
                           );
                                                  }
                       } catch (e) {
                         showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return AlertDialog(
                               title: Text('Google Maps Not Found'),
                               content: Text('Google Maps is not installed on your device. Install Google Maps to see officer locations.'),
                               actions: <Widget>[
                                 TextButton(
                                   child: Text('OK'),
                                   onPressed: () {
                                     Navigator.of(context).pop();
                                   },
                                 ),
                               ],
                             );
                           },
                         );
                       }
                     }
                   }),*/


                   Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => provider.pagingController.refresh(),
                  ),
                  child: PagedListView<int, Datum>.separated(
                      pagingController: provider.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Datum>(
                          animateTransitions: true,
                          itemBuilder: (context, data, index) {
                            // Translate the index into Bangla.
                            final banglaIndex = NumberFormat.compact(locale: 'bn-BD').format(index + 1);
                            return InkWell(
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomSimpleText(text: '${banglaIndex}.', fontWeight: FontWeight.bold,),
                                      SizedBox(width: 5,),
                                      CustomSimpleText(
                                          text: data.name!.toUpperCase(),
                                          fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        ),

                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.stationDetailsScree,arguments: data);
                              },
                            );
                          }),
                      separatorBuilder: (context, index) => const SizedBox()),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void openGoogleMaps(List<Map<String, dynamic>> markers) async {
    final markerQueries = markers.map((marker) {
      final latitude = marker['latitude'];
      final longitude = marker['longitude'];
      final title = Uri.encodeComponent(marker['title']);
      return '($latitude,$longitude)?q=$title';
    }).join('&');

    final url = 'https://www.google.com/maps/search/?api=1&$markerQueries';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

}
