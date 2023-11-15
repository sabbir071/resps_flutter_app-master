
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pollingstation/config/constant.dart';
import 'package:pollingstation/provider/officer_provider.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../model/DropdownModel.dart';
import '../../../provider/app_provider.dart';
import '../../widget/circle_image.dart';
import '../../widget/custom_dropdown.dart';

class PollingOfficerListScreen extends StatelessWidget {
 // final Datum data;

  PollingOfficerListScreen({super.key/*, required this.data*/});

  @override
  Widget build(BuildContext context) {
    int? division = 0;
    int? district = 0;
    int? sub_district = 0;
    int? union = 0;
   Provider.of<OfficerProvider>(context, listen: false).getPollingOfficerList(context);
    return Consumer<OfficerProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'পোলিং অফিসারে তালিকা',
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Consumer<AppProvider>(builder: (context, appProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 2 - 13,
                          child: appProvider.isDivisionLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropDown(
                            fieldTitle: "Select Division",
                            spinnerItemList: appProvider.divisionList,
                            selectedItem: appProvider.selectedDivision ??
                                appProvider.divisionList.first,
                            onChanged: (DropdownModel model) {
                              appProvider.setSelectDivision(model);
                              division = model.id;
                              provider.getPollingOfficerList(context, division: division);
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: MediaQuery.of(context).size.width / 2 - 13,
                          child: appProvider.isDistrictLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropDown(
                            fieldTitle: "Select District",
                            spinnerItemList: appProvider.districtList,
                            selectedItem: appProvider.selectedDistrict,
                            onChanged: (DropdownModel model) {
                              appProvider.setSelectDistrict(model);
                              district = model.id;
                              provider.getPollingOfficerList(context, division: division, district: district);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 2 - 13,
                          child: appProvider.isUpazilaLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropDown(
                            fieldTitle: "Select Upazila",
                            spinnerItemList: appProvider.upazilaList,
                            selectedItem: appProvider.selectedUpazila,
                            onChanged: (DropdownModel model) {
                              appProvider.setSelectedUpazila(model);
                              sub_district = model.id;
                              provider.getPollingOfficerList(context, division: division, district: district, sub_district: sub_district);
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: MediaQuery.of(context).size.width / 2 - 13,
                          child: appProvider.isUnionLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropDown(
                            fieldTitle: "Select Union",
                            spinnerItemList: appProvider.unionList,
                            selectedItem: appProvider.selectedUnion,
                            onChanged: (DropdownModel model) {
                              appProvider.setSelectUnion(model);
                              union = model.id;
                              provider.getPollingOfficerList(context, division: division, district: district, sub_district: sub_district, union:  union);

                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: provider.isPollingOfficerListLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : provider.pollingOfficerList.isEmpty? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Polling officer list not found'),
                      ],
                    ),
                  )
                    : ListView.builder(
                        itemCount: provider.pollingOfficerList.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, position) {
                          final pollingOfficer = provider.pollingOfficerList[position];
                          return Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              AnimationConfiguration.staggeredList(
                                position: position,
                                duration: const Duration(seconds: 1),
                                child: SlideAnimation(
                                  horizontalOffset: 500.0,
                                  child: SlideAnimation(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              child: circleNetworkImage(
                                                  pollingOfficer.photo ?? manImage, 70, 70)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomSimpleText(
                                                  text: pollingOfficer.name != null ?  'Name: ${ pollingOfficer.name}'
                                                      : '', fontSize: 16, fontWeight: FontWeight.bold,),
                                              CustomSimpleText(
                                                text: pollingOfficer.designation != null ? 'Designation: ${ pollingOfficer.designation}' : '',
                                                fontSize: 14,
                                                alignment: TextAlign.start,
                                              ),
                                              CustomSimpleText(
                                                text: pollingOfficer.phone != null ? 'Contact: ${ pollingOfficer.phone}' : '',
                                                fontSize: 14,
                                                alignment: TextAlign.start,
                                              ),
                                              CustomSimpleText(
                                                text: pollingOfficer.phone != null ? 'Center: ${ pollingOfficer.center?.name}' : '',
                                                fontSize: 14,
                                                alignment: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),

              ),
            ],
          ),
        );
      }
    );
  }

}
