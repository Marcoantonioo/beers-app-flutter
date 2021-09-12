import 'package:app_miles/app_miles.dart';
import 'package:get_it/get_it.dart';

class HttpDI {
  static void registerAll(GetIt container) {
    container.registerFactory<HttpRemote>(() => HttpRequestProvider(
        baseUrl: 'http://104.131.116.123/public/',
        sessionRepository: container.get()));
  }
}
