import 'package:beers_app/domain/beer.dart';

abstract class BeerRepository {
  Future<List<Beer>> loadAll();
}
