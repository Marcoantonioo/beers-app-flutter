import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/presentation/bloc/base_bloc.dart';
import 'package:beers_app/presentation/bloc/home/home_event.dart';
import 'package:beers_app/repository/beer_repository.dart';

class HomeBloc extends BaseBloc<HomeEvent> {
  final BeerRepository? _beerRepository;

  HomeBloc({
    required BeerRepository? beerRepository,
  })  : _beerRepository = beerRepository,
        assert(beerRepository != null);
  @override
  void dispatchEvent(HomeEvent event) => dispatchOn<HomeEvent>(event);

  @override
  void init() {
    /// escuta os eventos
    listenOn<HomeEvent>(handleEvent);
  }

  @override
  void handleEvent(HomeEvent event) {
    if (event is LoadAll) {
      _loadAll();
    }
    if (event is Details) {
      /// TODO
    }
  }

  void _loadAll() async {
    await doOnlineAction(
      action: () async {
        /// apenas para demorar um pouco mais a requisição hehe
        await Future.delayed(Duration(seconds: 3));
        handleCallRepository();
      },
    );
  }

  void handleCallRepository() {
    _beerRepository!.loadAll().then((value) => dispatchValueList(value));
  }

  void dispatchValueList(List<Beer> value) {
    dispatchOn<List<Beer>>(
      value,
      key: HomeKey.LIST,
    );
  }
}

enum HomeKey { LIST }
