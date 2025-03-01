import 'package:ecoland_application/screens/production_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecoland_application/screens/signup_screen.dart';
import 'package:ecoland_application/screens/sign_in_screen.dart';
import 'package:ecoland_application/screens/overview_screen.dart';
import 'package:ecoland_application/screens/user_settings_screen.dart';

class Routes {
  static const String signUp = '/sign-up';
  static const String signIn = '/sign-in';
  static const String overview = '/overview';
  static const String userSettings = '/user-settings';
  static const String production = '/production';

  static final Map<String, WidgetBuilder> routes = {
    signUp: (context) => const SignupScreen(),
    signIn: (context) => const SignInScreen(),
    overview: (context) => const OverviewScreen(),
    userSettings: (context) => const UserSettingsScreen(),
    production: (context) => const ProductionScreen()
  };
}
