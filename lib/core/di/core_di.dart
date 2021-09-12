import 'package:app_miles/app_miles.dart';
import 'package:app_miles/core/di/session_di.dart';
import 'package:get_it/get_it.dart';

final container = GetIt.instance;

class CoreDI {
  static void registerAll() {
    SystemDI.registerAll(container);
    HttpDI.registerAll(container);
    AuthenticationDI.registerAll(container);
    LoginDI.registerAll(container);
    SessionDI.registerAll(container);
  }

  static T resolve<T extends Object>() {
    return container.get<T>();
  }
}
