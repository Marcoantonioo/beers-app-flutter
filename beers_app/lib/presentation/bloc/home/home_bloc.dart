import 'package:beers_app/core/sys/bloc/sys_bloc.dart';
import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/presentation/bloc/base_bloc.dart';
import 'package:beers_app/presentation/bloc/home/home_event.dart';
import 'package:beers_app/repository/beer_repository.dart';

class HomeBloc extends BaseBloc<HomeEvent> {
  final BeerRepository? _beerRepository;

  int page = 0;
  int perPage = 20;

  List<Beer> mainList = [];

  HomeBloc({
    required SysBloc sysBloc,
    required BeerRepository? beerRepository,
  })  : _beerRepository = beerRepository,
        assert(beerRepository != null),
        super(sysBloc: sysBloc);
  @override
  void dispatchEvent(HomeEvent event) => dispatchOn<HomeEvent>(event);

  @override
  void init() {
    /// escuta os eventos
    listenOn<HomeEvent>(handleEvent);
     _loadAll();
  }

  @override
  void handleEvent(HomeEvent event) {
    if (event is LoadAll) {
      _loadAll();
    }
    if (event is Details) {
      _navigateToDetails((event).entity);
    }
  }

  void _navigateToDetails(Beer? beer) {
    navigateForward<Beer>('/details', routeParameter: beer);
  }

  void _loadAll() async {
    await doOnlineAction(
      action: () async {
        handleCallRepository();
      },
    );
  }

  void handleCallRepository() {
    /// a cada chamada incrementamos a pagina.
    page += 1;
    _beerRepository!.loadAll(page, perPage).then(
          (value) => dispatchValueList(value),
        );
  }

  void dispatchValueList(List<Beer> value) {
    /// para cada resultado retornado do repository
    /// incrementamos a lista atual [mainList]
    value.forEach((it) {
      mainList.add(it);
    });

    dispatchOn<List<Beer>>(
      mainList,
      key: HomeKey.LIST,
    );
  }
}

enum HomeKey { LIST }
