import 'package:beers_app/core/strategys/navigate/strategy_route.dart';
import 'package:beers_app/core/strategys/navigate/strategy_route_default.dart';
import 'package:beers_app/core/sys/router/dispatcher.dart';
import 'package:beers_app/core/sys/router/navigation_service.dart';
import 'package:beers_app/core/sys/router/route.dart';
import 'package:fancy_stream/fancy_stream.dart';

class DispatchRouterImpl extends FancyDelegate implements DispatchRouter {
  late StrategyRoute _strategyRoute;

  void init({StrategyRoute? strategyRoute}) {
    _strategyRoute = strategyRoute ?? StrategyRouteDefault(NavigationService());
    listenOn<SysRoute>(onRouteDispatched);
  }

  @override
  void dispatch(SysRoute route) {
    dispatchOn<SysRoute>(route);
  }

  void onRouteDispatched(SysRoute sysRoute) {
    _strategyRoute.onRoute(sysRoute);
  }
}
