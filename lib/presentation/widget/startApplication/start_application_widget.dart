import 'dart:async';
import 'package:app_miles/core/system/model/system.dart';
import 'package:app_miles/core/system/strategys/init/strategy.dart';
import 'package:app_miles/core/system/strategys/message/strategy_message.dart';
import 'package:app_miles/core/system/strategys/navigate/strategy.dart';
import 'package:flutter/material.dart';

class StartApplicationWidget extends StatefulWidget {
  final BuilderChild? child;
  final StrategyInit? strategyInit;
  final BuilderStrategyNavigate? strategyNavigate;
  final BuilderStrategyMessage? strategyMessage;

  const StartApplicationWidget({
    this.child,
    this.strategyInit,
    this.strategyNavigate,
    this.strategyMessage,
  })  : assert(child != null),
        assert(strategyInit != null),
        assert(strategyNavigate != null),
        assert(strategyMessage != null);

  @override
  _StartApplicationWidgetState createState() => _StartApplicationWidgetState();
}

class _StartApplicationWidgetState extends State<StartApplicationWidget>
    with WidgetsBindingObserver {
  Widget get child => widget.child!(context);
  StrategyInit get strategyInit => widget.strategyInit!;
  StrategyNavigate get strategyNavigate => widget.strategyNavigate!(context);
  StrategyMessage get strategyMessage => widget.strategyMessage!(context);

  StreamSubscription? _subsSysNavigate;
  StreamSubscription? _subsSysMessage;

  @override
  void initState() {
    _initFunctions();
    _initNavigateListner();
    _initMessageListner();
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    _subsSysNavigate?.cancel();
    _subsSysMessage?.cancel();
    super.dispose();
  }

  void _initFunctions() {
    strategyInit.functionsToExecute.forEach(
      (f) => f(),
    );
  }

  void _initNavigateListner() {
    _subsSysNavigate = strategyNavigate.sysNavigate.listen(
      (r) => strategyNavigate.onNavigate(context, r),
    );
  }

  void _initMessageListner() {
    _subsSysMessage = strategyMessage.sysMessage.listen(_onMessage);
  }

  void _onMessage(SysMessageModel message) {
    switch (message.key) {
      case SysSuccessMessageModel.keyValue:
        strategyMessage.showSuccessMessage(message as SysSuccessMessageModel);
        break;
      case SysErrorMessageModel.keyValue:
        strategyMessage.showErrorMessage(message as SysErrorMessageModel);
        break;
      case SysDialogMessageModel.keyValue:
        strategyMessage.showLoadingDialog(message as SysDialogMessageModel);
        break;
      case SysDismissDialogMessageModel.keyValue:
        strategyMessage
            .dismissLoagindDialog(message as SysDismissDialogMessageModel);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

typedef BuilderChild = Widget Function(BuildContext context);
typedef BuilderStrategyNavigate = StrategyNavigate Function(
    BuildContext context);
typedef BuilderStrategyMessage = StrategyMessage Function(BuildContext context);
