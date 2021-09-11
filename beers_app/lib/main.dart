import 'package:beers_app/di/application_di.dart';
import 'package:beers_app/presentation/screens/home_page.dart';
import 'package:beers_app/presentation/widget/start_application_widget.dart';
import 'package:beers_app/core/strategys/strategy_init_impl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartApplicationWidget(
        child: _buildHomeContent,
        strategyInit: strategyInit,
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return HomePage.create(context);
  }

  StrategyInitImpl get strategyInit => StrategyInitImpl(
        ApplicationDI.registerAll,
      );
}
