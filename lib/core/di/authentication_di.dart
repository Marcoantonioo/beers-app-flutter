import 'package:app_miles/data/data.dart';
import 'package:app_miles/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class AuthenticationDI {
  static void registerAll(GetIt container) {
    container.registerFactory<AuthenticationStore>(
        () => AuthenticationRemote(httpRemote: container.get()));

    container.registerFactory<AuthenticationRepository>(
        () => AuthenticationDataRepository(remote: container.get()));

    container.registerFactory(() => AuthenticationBloc(
        sessionRepository: container.get(), systemBloc: container.get()));
  }
}
