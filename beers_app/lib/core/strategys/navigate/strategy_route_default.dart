import 'package:beers_app/core/strategys/navigate/strategy_route.dart';
import 'package:beers_app/core/sys/router/navigation_service.dart';
import 'package:beers_app/core/sys/router/route_back.dart';
import 'package:beers_app/core/sys/router/route_forward.dart';
import 'package:flutter/cupertino.dart';

///Implementação padrão do [StrategyRoute].
@immutable
class StrategyRouteDefault extends StrategyRoute {
  StrategyRouteDefault(NavigationService navigationService)
      : super(navigationService);

  @override
  void onForward(RouteForward routeForwardModel) {
    navigationService.navigator
        ?.pushNamed(routeForwardModel.route,
            arguments: routeForwardModel.routeParameter)
        .then((completedObject) =>
            routeForwardModel.onComplete?.call(completedObject));
  }

  @override
  void onBack(RouteBack routeBackModel) {
    if (routeBackModel.route == null) {
      navigationService.navigator?.pop(routeBackModel.routeParameter);
    } else {
      navigationService.navigator
          ?.popUntil(ModalRoute.withName(routeBackModel.route ?? "/"));
    }
  }
}