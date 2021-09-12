import 'package:beers_app/core/sys/router/dispatcher.dart';
import 'package:beers_app/core/sys/router/route.dart';

class SysBloc {
  final DispatchRouter dispatchRouter;

  SysBloc({
    required this.dispatchRouter,
  });

  void dispatchRoute(SysRoute route) {
    dispatchRouter.dispatch(route);
  }
}