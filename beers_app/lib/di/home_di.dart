import 'package:beers_app/presentation/bloc/home/home_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeDI {
  static void registerAll(GetIt container) {
    container.registerFactory(() => HomeBloc(
          beerRepository: container.get(),
          sysBloc: container.get(),
        ));
  }
}
