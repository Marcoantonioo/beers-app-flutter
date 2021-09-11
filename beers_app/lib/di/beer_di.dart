import 'package:beers_app/repository/beer_repository.dart';
import 'package:beers_app/repository/beer_repository_impl.dart';
import 'package:get_it/get_it.dart';

class BeerDI {
  static void registerAll(GetIt container) {
    container.registerFactory<BeerRepository>(
        () => BeerRepositoryImpl(httpRemote: container.get()));
  }
}
