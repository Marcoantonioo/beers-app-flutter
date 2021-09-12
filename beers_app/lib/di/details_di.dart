import 'package:beers_app/presentation/bloc/details/details_bloc.dart';
import 'package:get_it/get_it.dart';

class DetailsDI {
  static void registerAll(GetIt container) {
    container.registerFactory(() => DetailsBloc(sysBloc: container.get()));
  }
}
