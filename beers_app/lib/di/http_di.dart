import 'package:beers_app/core/constants.dart';
import 'package:beers_app/core/http/http_remote.dart';
import 'package:beers_app/core/http/http_remote_impl.dart';
import 'package:get_it/get_it.dart';

class HttpDI {
  static void registerAll(GetIt container) {
    container
        .registerFactory<HttpRemote>(() => HttpRemoteImpl(baseUrl: BASE_URL));
  }
}
