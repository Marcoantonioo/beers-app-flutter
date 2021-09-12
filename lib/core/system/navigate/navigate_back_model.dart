import 'package:app_miles/core/system/navigate/navigate.dart';
/// Classe responsável pelo comportamento de retornar no sistema
/// de navegação
class NavigateBackModel extends NavigateModel {
  const NavigateBackModel({
    String? route,
    parameter,
  }) : super(
          route: route,
          parameter: parameter,
        );
}
