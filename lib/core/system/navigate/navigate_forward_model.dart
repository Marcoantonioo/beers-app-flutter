import 'package:app_miles/core/system/navigate/navigate.dart';

/// Classe responsável pelo comportamento de avançar no sistema
/// de navegação
class NavigateForwardModel<T> extends NavigateModel {
  final CallbackRoute<T>? onComplete;

  const NavigateForwardModel({
    String? route,
    dynamic parameter,
    this.onComplete,
  }) : super(
          route: route,
          parameter: parameter,
        );
}
