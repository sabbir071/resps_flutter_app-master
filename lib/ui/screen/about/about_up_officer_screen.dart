import 'package:flutter/material.dart';
import 'package:pollingstation/res/app_icon.dart';

import '../../widget/custom_text.dart';

class AboutUPOfficerScreen extends StatelessWidget {
  const AboutUPOfficerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Shajahanpur Upazila',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    'image asset' ?? ' ',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                       AppIcon.officerSaida,
                        // Replace with your default image asset path
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: const Color(0x008000).withOpacity(0.3),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomSimpleText(
                              text: 'Shajahanpur Upazila' ?? 'N/A',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 1),
                          const Center(
                            child: CustomSimpleText(
                              text: 'Shajahanpur Upazila is an upazila of Bogra District in the Division of Rajshahi, Bangladesh.',
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContactInfoRow(
                      Icons.phone, 'Phone Number:', '০২৫৮৮৮৭৭১১১' ?? 'N/A'),
                  const SizedBox(height: 15), // Add spacing between sections
                  buildContactInfoRow(
                      Icons.email, 'Email:', 'unoshajahanpur@mopa.gov.bd' ?? 'N/A'),
                  const SizedBox(height: 15), // Add spacing between sections
                  buildContactInfoRow(
                      Icons.location_on, 'Address:', 'Shajahanpur Upazila, Bogura, Bangladesh' ?? 'N/A'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContactInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSimpleText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            const SizedBox(height: 5),
            CustomSimpleText(
              text: value,
              fontSize: 14,
            ),
          ],
        ),
      ],
    );
  }
}
