import 'package:ecoland_application/models/production.dart';

class Building {
  final String name;
  final int id;
  ProductionBase? production;
  DefType type;

  Building(
      {required this.name,
      required this.id,
      required this.type,
      this.production});

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(name: json['name'], id: json['id'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}

class DefType {
  int defId;
  String tokenName;

  DefType({
    required this.defId,
    required this.tokenName,
  });
}
