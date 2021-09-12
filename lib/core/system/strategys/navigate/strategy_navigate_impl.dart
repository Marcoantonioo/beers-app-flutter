import 'package:app_miles/core/system/model/system.dart';
import 'package:app_miles/core/system/navigate/navigate.dart';
import 'package:app_miles/core/system/navigate/navigate_forward_model.dart';
import 'package:app_miles/core/system/strategys/navigate/strategy.dart';
import 'package:flutter/cupertino.dart';

class StrategyNavigateImpl implements StrategyNavigate {
  @override
  final Stream<SysNavigateModel> sysNavigate;

  StrategyNavigateImpl(this.sysNavigate);

  @override
  void onNavigate<T>(BuildContext context, SysNavigateModel sysNavigate) {
    if (sysNavigate.navigateBack != null) {
      _onBack(context, sysNavigate.navigateBack!);
    }
    if (sysNavigate.navigateForward != null) {
      _onForward<T>(context, sysNavigate.navigateForward!);
    }
  }

  void _onForward<T>(
      BuildContext context, NavigateForwardModel navigateForward) {
    Navigator.of(context)
        .pushNamed<T>(navigateForward.route!,
            arguments: navigateForward.parameter)
        .then<dynamic>(
          (T? completedObject) =>
              navigateForward.onComplete?.call(completedObject),
        );
  }

  void _onBack(BuildContext context, NavigateBackModel navigateBack) {
    if (navigateBack.route == null) {
      Navigator.of(context).pop<dynamic>(navigateBack.parameter);
    } else {
      Navigator.popUntil(
        context,
        ModalRoute.withName(navigateBack.route ?? '/'),
      );
    }
  }
}
