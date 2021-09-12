import 'package:beers_app/di/beer_di.dart';
import 'package:beers_app/di/home_di.dart';
import 'package:beers_app/di/http_di.dart';
import 'package:beers_app/di/sys_di.dart';
import 'package:get_it/get_it.dart';

final container = GetIt.instance;

/// Injeção de dependencias da applicação
class ApplicationDI {
  static void registerAll() {
    HttpDI.registerAll(container);
    BeerDI.registerAll(container);
    HomeDI.registerAll(container);
    SysDI.registerAll(container);
  }

  static T resolve<T extends Object>() {
    return container.get<T>();
  }
}
