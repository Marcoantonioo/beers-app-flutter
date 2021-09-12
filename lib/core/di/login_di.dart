import 'package:app_miles/presentation/bloc/login/login_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginDI {
  static void registerAll(GetIt container) {
    container.registerFactory(() => LoginBloc(
        authenticationRepository: container.get(),
        sessionRepository: container.get(),
        systemBloc: container.get()));
  }
}
