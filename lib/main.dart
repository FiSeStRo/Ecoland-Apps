import 'package:ecoland_application/navigation/routes.dart';
import 'package:ecoland_application/providers/authentication_provider.dart';
import 'package:ecoland_application/providers/buildings_provider.dart';
import 'package:ecoland_application/providers/user_settings_provider.dart';
import 'package:ecoland_application/screens/overview_screen.dart';
import 'package:ecoland_application/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => UserSettingsProvider()),
      ChangeNotifierProvider(create: (context) => BuildingsProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecoland',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OverviewScreen(), //TODO: Change back to signIn before PR
      routes: Routes.routes,
    );
  }
}
