class Endpoints {
  static _Authentication get authentication => _Authentication();
  static _User get user => _User();
  static _Building get building => _Building();
  static _Production get production => _Production();
  static _Transportation get transportation => _Transportation();
}

class _Authentication {
  final String signUp = '/authentication/sign-up';
  final String signIn = '/authentication/sign-in';
  final String refresh = '/authentication/refresh-token';
}

class _User {
  final String info = '/user/info';
  final String ressources = '/user/resources';
}

class _Building {
  final String list = '/buildings/list';
  final String construct = '/buildings/construct';
  final String constructionList = '/buildings/constructionlist';
  String details(int id) => '/buildings/details/$id';
}

class _Production {
  final String cancel = '/production/cancel';
  final String start = '/production/cancel';
  final String list = '/production/list';
}

class _Transportation {
  final String shipment = '/transportation/shipment';
}
