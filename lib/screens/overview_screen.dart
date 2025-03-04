import 'package:ecoland_application/components/building_card.dart';
import 'package:ecoland_application/components/construction_building.dart';
import 'package:ecoland_application/models/building.dart';
import 'package:ecoland_application/navigation/routes.dart';
import 'package:ecoland_application/providers/buildings_provider.dart';
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
    int _selectedIndex = 0;
    final userSettings = Provider.of<UserSettingsProvider>(context);
    final buildingsP = Provider.of<BuildingsProvider>(context);
    final List<Building> buildings = buildingsP.buildings;
    List<Widget> buildings_container = [];
    for (var building in buildings) {
      buildings_container.add(BuildingCard(
        name: building.name,
        type: building.type.tokenName,
        hasActiveProduction: building.production?.isActive ?? false,
        onProductionTap: () =>
            {Navigator.of(context).pushNamed(Routes.production)},
      ));
    }

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.construction), label: 'build'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (int index) {
            switch (index) {
              case 0:
                print("Home clicked");
              case 1:
                //show construction Dialog
                showConstructBuildingDialog(context);
            }
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
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
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: buildings_container,
        ));
  }
}
