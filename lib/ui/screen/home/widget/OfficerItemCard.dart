import 'package:flutter/material.dart';
import 'package:pollingstation/config/constant.dart';

import '../../../widget/circle_image.dart';
import '../../../widget/custom_text.dart';

class OfficerItemCard extends StatelessWidget {

  final String? index;
  final String? personName;
  final String? className;
  final String? sectionName;
  final int? position;
  final String? image;

  const OfficerItemCard({super.key,  this.index,  this.personName,  this.className,  this.sectionName, this.position, this.image});

  @override
  Widget build(BuildContext context) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 5,
          shadowColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   // CustomSimpleText(text: roll),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(child: circleImage(image ?? govtImage, 50, 50)),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSimpleText(text: personName!, fontSize: 16),
                      /*  CustomSimpleText(
                          text:  className ?? '',
                          fontSize: 14,
                          alignment: TextAlign.start,
                        ),*/
                        CustomSimpleText(
                          text:  (className != null && sectionName != null)
                              ? '${className ?? ''} - ${sectionName ?? ''}'
                              : '${className ?? ''}',
                          fontSize: 12,
                          alignment: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
             // add more widgets here
              ],
            ),
          ),
        );

  }
}
