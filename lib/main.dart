import 'package:app_miles/core/di/core_di.dart';
import 'package:app_miles/core/system/bloc/system.dart';
import 'package:app_miles/core/system/strategys/init/strategy_init_impl.dart';
import 'package:app_miles/core/system/strategys/message/strategy_message_impl.dart';
import 'package:app_miles/core/system/strategys/navigate/strategy_navigate_impl.dart';
import 'package:app_miles/presentation/widget/dialog/base_dialog_state/dialog_wrapper.dart';
import 'package:app_miles/presentation/widget/root/root_widget.dart';
import 'package:app_miles/presentation/widget/startApplication/start_application_widget.dart';
import 'package:app_miles/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings routeSettings) {
        //Para que a navegação para um dialog aconteça
        //o caminho da rota deve conter o nome "dialog",
        //assim um Wrapper para este será adicionado na navegação
        //permitindo o overlay na tela
        if (routeSettings.name!.contains('dialog')) {
          return DialogWrapper<dynamic>(
            child: (context) => routes[routeSettings.name]!.call(context),
            settings: routeSettings,
          );
        } else {
          return MaterialPageRoute<dynamic>(
            builder: (context) => routes[routeSettings.name]!.call(context),
            settings: routeSettings,
          );
        }
      },
      home: StartApplicationWidget(
        child: _buildHomeContent,
        strategyInit: strategyInit,
        strategyNavigate: strategyNavigate,
        strategyMessage: strategyMessage,
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return RootWidget.create(context);
  }

  StrategyInitImpl get strategyInit => StrategyInitImpl(CoreDI.registerAll);

  StrategyNavigateImpl strategyNavigate(BuildContext context) =>
      StrategyNavigateImpl(CoreDI.resolve<SystemBloc>().sysNavigate);

  StrategyMessageImpl strategyMessage(BuildContext context) =>
      StrategyMessageImpl(context, CoreDI.resolve<SystemBloc>().sysMessage);
}
