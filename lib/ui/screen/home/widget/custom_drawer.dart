import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pollingstation/provider/app_provider.dart';
import 'package:pollingstation/provider/officer_provider.dart';
import 'package:pollingstation/route.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../res/app_icon.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    CustomSimpleText(
                        text: 'শাজাহানপুর উপজেলা প্রকল্প সমূহ',
                        color: Colors.white,
                        fontSize: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 17),
                          width: 90,
                          // Adjust the width as needed to fit the image
                          height: 90,
                          // Adjust the height as needed to fit the image
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                            AppIcon.officerSaidaKhanom,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            // This ensures the image stretches to the container's width
                            height: double
                                .infinity, // This ensures the image stretches to the container's height
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomSimpleText(
                            text:
                                'ঐতিহ্য, কৃষ্টি, উন্নয়নে হবে,\n শাজাহানপুর উপজেলার \nবাস্তবায়ন।',
                            color: Colors.white,
                            fontSize: 16),
                      ],
                    ),
                  ],
                ),
              )),

          ListTile(
            leading: const Icon(
              Icons.add_chart_outlined,
              color: Colors.green,
            ),
            title: const Text('Project Category'),
            onTap: () {
              Navigator.pushNamed(
                  context, RouteName.presidingOfficerListScreen);
              provider.disposeData();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_box_outlined,
              color: Colors.green,
            ),
            title: const Text('Project List'),
            onTap: () {
              Navigator.pushNamed(context, RouteName.homeScreen);
              provider.disposeData();
              Provider.of<OfficerProvider>(context, listen: false).removeCurrentPage(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Colors.green,
            ),
            title: const Text('About Upazila'),
            onTap: () {
              Navigator.pushNamed(context, RouteName.upazilaOfficer);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.green,
            ),
            title: const Text('Exit!'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Exit!',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: Text('Are you sure to exit from app now?',
                          style: TextStyle(color: Colors.green)),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.green)),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            exit(0);
                          },
                          child: Text('Yes',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
