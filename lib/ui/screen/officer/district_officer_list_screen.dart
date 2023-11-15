
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pollingstation/config/constant.dart';
import 'package:pollingstation/model/dropdown_id.dart';
import 'package:pollingstation/provider/officer_provider.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';
import 'package:provider/provider.dart';

import '../../widget/circle_image.dart';

class DistrictOfficerListScreen extends StatelessWidget {
  final DropDownID data;

  DistrictOfficerListScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
   Provider.of<OfficerProvider>(context, listen: false).getDistrictOfficerList(context, division: data.division, district: data.district);
    return Consumer<OfficerProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'সংশ্লিষ্ট কর্মকর্তার তালিকা',
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: provider.isOfficerListLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : provider.districtOfficerList.isEmpty? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('District officer list not found'),
                  ],
                ),
              )
                : ListView.builder(
                    itemCount: provider.districtOfficerList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, position) {
                      final districtOfficer = provider.districtOfficerList[position];
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
                                     /* Container(
                                          child: circleNetworkImage(
                                              districtOfficer.image ?? manImage, 70, 70)),*/
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomSimpleText(
                                              text: districtOfficer.name != null ?  '${ districtOfficer.name}'
                                                  : '', fontSize: 16, fontWeight: FontWeight.bold,),
                                         /* CustomSimpleText(
                                            text: districtOfficer.designation != null ? 'Designation: ${ districtOfficer.designation}' : '',
                                            fontSize: 14,
                                            alignment: TextAlign.start,
                                          ),*/
                                        /*  CustomSimpleText(
                                            text: districtOfficer.phone != null ? 'Contact: ${ districtOfficer.phone}' : '',
                                            fontSize: 14,
                                            alignment: TextAlign.start,
                                          ),*/
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
        );
      }
    );
  }

}
