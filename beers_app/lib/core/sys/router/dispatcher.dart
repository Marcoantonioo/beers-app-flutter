import 'package:beers_app/core/sys/router/route.dart';

abstract class DispatchRouter {
  void dispatch(SysRoute route);
}