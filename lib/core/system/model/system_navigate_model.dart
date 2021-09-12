import 'package:app_miles/core/system/navigate/navigate_back_model.dart';
import 'package:app_miles/core/system/navigate/navigate_forward_model.dart';

class SysNavigateModel {
  final NavigateForwardModel? navigateForward;
  final NavigateBackModel? navigateBack;

  SysNavigateModel({
    this.navigateForward,
    this.navigateBack,
  });

  SysNavigateModel.navigateForward(String route, {Object? parameter})
      : navigateForward = NavigateForwardModel(
          route: route,
          parameter: parameter,
        ),
        navigateBack = null;

  SysNavigateModel.pop({Object? parameter})
      : navigateForward = null,
        navigateBack = NavigateBackModel(parameter: parameter);

  SysNavigateModel.toRoot()
      : navigateForward = null,
        navigateBack = const NavigateBackModel(route: '/');
}
