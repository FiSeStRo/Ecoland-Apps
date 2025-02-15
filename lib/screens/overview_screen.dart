import 'package:ecoland_application/navigation/routes.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ovierview"),
        actions: [
          ElevatedButton.icon(
            onPressed: () =>
                {Navigator.pushNamed(context, Routes.userSettings)},
            label: const Text("Settings"),
            icon: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
