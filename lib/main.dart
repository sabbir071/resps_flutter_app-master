import 'package:flutter/material.dart';
import 'package:pollingstation/provider/app_provider.dart';
import 'package:pollingstation/provider/officer_provider.dart';
import 'package:pollingstation/provider/search_provider.dart';
import 'package:pollingstation/provider/theme_provider.dart';
import 'package:pollingstation/route.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> ThemeProvider()),
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => OfficerProvider()),
    ChangeNotifierProvider(create: (_) => SearchProvider())
  ],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Polling Station',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: provider.themeMode,
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: onGenerateRoute);
    });
  }
}