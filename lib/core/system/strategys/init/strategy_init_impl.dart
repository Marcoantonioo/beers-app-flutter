import 'package:app_miles/core/system/strategys/init/strategy.dart';

class StrategyInitImpl implements StrategyInit {
  final Function() _registerDI;

  StrategyInitImpl(this._registerDI);

  @override
  Iterable<InitAction> get functionsToExecute => <InitAction>[
        _registerDI,
      ];
}