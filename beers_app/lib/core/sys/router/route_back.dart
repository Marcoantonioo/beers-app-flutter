import 'package:beers_app/core/sys/router/base_route.dart';

///Classe responsável por criar o comportamento de voltar
///no sistema de rotas
class RouteBack extends BaseRoute {
  RouteBack({String? route, Object? routeParameter})
      : super(route: route, routeParameter: routeParameter);

  factory RouteBack.pop({Object? routeParameter}) =>
      RouteBack(routeParameter: routeParameter);

  factory RouteBack.popUntil(String route) => RouteBack(route: route);

  factory RouteBack.toRoot() => RouteBack(route: "/");
}