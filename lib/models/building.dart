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

class ConBuilding {
  final int id;
  final String name;
  final int cost;
  final int time;

  ConBuilding(
      {required this.id,
      required this.name,
      required this.cost,
      required this.time});

  factory ConBuilding.fromJson(Map<String, dynamic> json) {
    return ConBuilding(
      id: json['def_id'],
      name: json['token_name'],
      cost: json['cost'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
      'iime': time,
    };
  }
}
