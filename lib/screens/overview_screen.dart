import 'package:ecoland_application/navigation/routes.dart';
import 'package:ecoland_application/providers/user_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final userSettings = Provider.of<UserSettingsProvider>(context);
    final username = userSettings.userName;
    final email = userSettings.eMail;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ovierview"),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              await userSettings.loadUserSettings();
              Navigator.pushNamed(context, Routes.userSettings);
            },
            label: const Text("Settings"),
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Username: $username"),
            Text("Email: $email"),
          ],
        ),
      ),
    );
  }
}
