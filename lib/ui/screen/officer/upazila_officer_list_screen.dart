
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pollingstation/config/constant.dart';
import 'package:pollingstation/model/dropdown_id.dart';
import 'package:pollingstation/provider/officer_provider.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';
import 'package:provider/provider.dart';

import '../../widget/circle_image.dart';

class UpazilaOfficerListScreen extends StatelessWidget {
  final DropDownID data;

  UpazilaOfficerListScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
   Provider.of<OfficerProvider>(context, listen: false).getUpazilaOfficerList(context, division: data.division, district: data.district, upazila: data.subDistrict);
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
            child: provider.isUpazilaOfficerListLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : provider.upazilaOfficerList.isEmpty? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Upazila officer list not found'),
                  ],
                ),
              )
                : ListView.builder(
                    itemCount: provider.upazilaOfficerList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, position) {
                      final upazilaOfficer = provider.upazilaOfficerList[position];
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
                                              upazilaOfficer.image ?? manImage, 70, 70)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomSimpleText(
                                              text: upazilaOfficer.name != null ?  'Name: ${ upazilaOfficer.name}'
                                                  : '', fontSize: 16, fontWeight: FontWeight.bold,),
                                          CustomSimpleText(
                                            text: upazilaOfficer.designation != null ? 'Designation: ${ upazilaOfficer.designation}' : '',
                                            fontSize: 14,
                                            alignment: TextAlign.start,
                                          ),
                                          CustomSimpleText(
                                            text: upazilaOfficer.phone != null ? 'Contact: ${ upazilaOfficer.phone}' : '',
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
        );
      }
    );
  }

}
