import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:pollingstation/provider/theme_provider.dart';
import 'package:pollingstation/route.dart';
import 'package:pollingstation/ui/screen/home/widget/custom_drawer.dart';
import 'package:provider/provider.dart';

import '../about/about_screen.dart';
import 'home_screen.dart';

// icon and label set for bottom navigation. Add new if needed
List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.info_rounded),
    label: 'About',
  )
];

const List<Widget> bottomNavScreen = <Widget>[
  HomeScreen(),
  AboutScreen(),
];

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            bottomNavItems[provider.fetchCurrentScreenIndex].label.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              ),
              onTap: () {
                Navigator.pushNamed(context, RouteName.searchScreen);
              },
            )
          ],
        ),
        drawer: const CustomDrawer(),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to exit')),
          child: Center(
            child: bottomNavScreen.elementAt(provider.fetchCurrentScreenIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: bottomNavItems,
          currentIndex: provider.fetchCurrentScreenIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          onTap: (value) => provider.updateScreenIndex(value),
        ),
      );
    });
  }
}
