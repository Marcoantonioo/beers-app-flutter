import 'dart:async';

import 'package:beers_app/core/strategys/strategy_init.dart';
import 'package:flutter/cupertino.dart';

class StartApplicationWidget extends StatefulWidget {
  final BuilderChild? child;
  final StrategyInit? strategyInit;

  const StartApplicationWidget({
    this.child,
    this.strategyInit,
  })  : assert(child != null),
        assert(strategyInit != null);

  @override
  _StartApplicationWidgetState createState() => _StartApplicationWidgetState();
}

class _StartApplicationWidgetState extends State<StartApplicationWidget>
    with WidgetsBindingObserver {
  Widget get child => widget.child!(context);
  StrategyInit get strategyInit => widget.strategyInit!;

  StreamSubscription? _subsSysNavigate;
  @override
  void initState() {
    _initFunctions();
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    _subsSysNavigate?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  void _initFunctions() {
    strategyInit.functionsToExecute.forEach((function) {
      function();
    });
  }
}

typedef BuilderChild = Widget Function(BuildContext context);
