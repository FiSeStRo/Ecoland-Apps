///Production_Base
class ProductionBase {
  Cycles cycles;

  int? id;
  bool isActive;
  List<ProductionsInOutList> productsIn;
  List<ProductionsInOutList> productsOut;
  DateTime timeEnd;

  ProductionBase({
    required this.cycles,
    required this.id,
    required this.isActive,
    required this.productsIn,
    required this.productsOut,
    required this.timeEnd,
  });
}

class Cycles {
  int completed;
  int total;

  Cycles({
    required this.completed,
    required this.total,
  });
}

class ProductionsInOutList {
  Amount amount;

  int id;
  String tokenName;

  ProductionsInOutList({
    required this.amount,
    required this.id,
    required this.tokenName,
  });
}

class Amount {
  int current;
  int total;

  Amount({
    required this.current,
    required this.total,
  });
}
