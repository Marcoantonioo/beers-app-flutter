import 'package:beers_app/core/http/http_remote.dart';
import 'package:beers_app/core/http/request.dart';
import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/repository/beer_repository.dart';

class BeerRepositoryImpl extends BeerRepository {
  final HttpRemote? _httpRemote;

  BeerRepositoryImpl({
    required HttpRemote? httpRemote,
  })  : _httpRemote = httpRemote,
        assert(httpRemote != null);
  static const _endpoint = 'beers';

  @override
  Future<List<Beer>> loadAll(int page, int perPage ) async {
    final request = await _httpRemote!.doRequest(RequestModel(
      endpoint: _endpoint,
      method: Method.GET,
      queryParameters: {
        'page': '$page',
        'per_pag': '$perPage',
      },
    ));
    return request.map((e) => Beer.fromJson(e)).toList();
  }
}
