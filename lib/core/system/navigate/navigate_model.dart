import 'package:meta/meta.dart';

/// Clase base usada para [NavigateForwardModel] e [NavigateBackModel]
class NavigateModel {
  final String? route;
  final dynamic parameter;

  const NavigateModel({
    @required this.route,
    this.parameter,
  });
}

typedef CallbackRoute<T> = Function(T onCompleteData);
