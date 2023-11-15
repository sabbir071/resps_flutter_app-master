import 'package:flutter/material.dart';
import 'package:pollingstation/ui/widget/custom_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              CustomSimpleText(
                text: 'Bangladesh Election Commission ',
                fontSize: 24,
                color: Colors.green,
              ),
              infoCard('ইউনিয়ন পরিষদের সংখ্যা - ০৯ টি'),
              infoCard('সংসদীয় আসন ৪২-বগুড়া-৭(গাবতলী ও শাজাহানপুর উপজেলা)'),
              infoCard('ক্যান্টনবোর্ড সংখ্যা - ০১ টি'),
              infoCard('বগুড়া পৌরসভার ০৩ টি ওয়ার্ড যথাক্রমে\n( ১৩,১৪ এবং ২১ নং)'),
              infoCard('ভোটার এলাকার সংখ্যা - ১৭৮ টি'),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title) {
    return Card(
      elevation: 5,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomSimpleText(
                text: '$title ',
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
