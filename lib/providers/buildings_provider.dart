import 'package:ecoland_application/models/building.dart';
import 'package:ecoland_application/models/production.dart';
import 'package:ecoland_application/providers/api/api.dart';
import 'package:ecoland_application/providers/api/endpoints.dart';
import 'package:flutter/material.dart';

class BuildingsProvider with ChangeNotifier {
  //TODo: Test Data to be replaced with call to get buildings
  final List<Building> _buildings = [
    Building(
      name: 'Farm',
      id: 1,
      type: DefType(defId: 100, tokenName: 'Agriculture'),
      production: ProductionBase(
        cycles: Cycles(completed: 0, total: 10),
        id: 1,
        isActive: true,
        productsIn: [],
        productsOut: [],
        timeEnd: DateTime.now().add(const Duration(hours: 1)),
      ),
    ),
    Building(
      name: 'Factory',
      id: 2,
      type: DefType(defId: 101, tokenName: 'Manufacturing'),
      production: ProductionBase(
        cycles: Cycles(completed: 2, total: 8),
        id: 2,
        isActive: true,
        productsIn: [],
        productsOut: [],
        timeEnd: DateTime.now().add(const Duration(hours: 2)),
      ),
    ),
    Building(
      name: 'Warehouse',
      id: 3,
      type: DefType(defId: 102, tokenName: 'Storage'),
      production: ProductionBase(
        cycles: Cycles(completed: 5, total: 12),
        id: 3,
        isActive: false,
        productsIn: [],
        productsOut: [],
        timeEnd: DateTime.now().add(const Duration(hours: 3)),
      ),
    ),
  ];

  //Getters
  get buildings => _buildings;

  Future<dynamic> getBuildingList() async {
    try {
      final response = await ApiClient().get(Endpoints.building.list);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final List<Building> fetchedBuildings = response.data['buildings']
            .map<Building>((buildingData) => Building.fromJson(buildingData))
            .toList();
        _buildings.clear();
        _buildings.addAll(fetchedBuildings);
        notifyListeners();
        return _buildings;
      } else {
        throw Exception('Failed to load buildings: ${response.statusCode}');
      }
    } catch (e) {
      print("getting building list failed with $e");
      return _buildings;
    }
  }
}
