import 'package:flutter/material.dart';
import 'package:pollingstation/provider/theme_provider.dart';
import 'package:pollingstation/res/app_icon.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false).splashInit(context);
    return  Scaffold(
      body: Container(
        width: double.infinity, // Set the width to fill the screen horizontally
        height: double.infinity, // Set the height to fill the screen vertically
        child: Image.asset(
          AppIcon.icApp,
          fit: BoxFit.cover, // Use BoxFit.cover to scale the image to cover the entire Container
        ),
      ) /*Center(
        child: Image.asset(AppIcon.icApp),
      ),*/
    );
  }
}
