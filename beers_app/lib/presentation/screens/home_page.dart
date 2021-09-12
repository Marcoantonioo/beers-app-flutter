import 'package:beers_app/di/application_di.dart';
import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/presentation/bloc/base_bloc.dart';
import 'package:beers_app/presentation/bloc/home/home_bloc.dart';
import 'package:beers_app/presentation/bloc/home/home_event.dart';
import 'package:beers_app/presentation/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage._();

  static Widget create(BuildContext context) {
    return Provider<HomeBloc>(
      create: (_) => ApplicationDI.resolve<HomeBloc>(),
      dispose: (_, value) => value.dispose(),
      child: const HomePage._(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get _bloc => Provider.of<HomeBloc>(context, listen: false);

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    /// quando chegar no fim da pagina carregamos mais
    if (_scrollController.position.atEdge) {
      _bloc.dispatchEvent(LoadAll());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Beers'),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<bool>(
      stream: _bloc.streamOf<bool>(key: BaseBlocKey.LOADING),
      builder: (_, snapshot) {
        final isLoading = snapshot.data ?? false;

        if (isLoading) {
          return _buildLoader();
        } else {
          return _buildList();
        }
      },
    );
  }

  Widget _buildList() {
    return StreamBuilder<List<Beer>>(
      stream: _bloc.streamOf<List<Beer>>(key: HomeKey.LIST),
      builder: (_, snapshot) {
        final list = snapshot.data;
        if (list == null) {
          return const SizedBox();
        }

        if (list.isEmpty) {
          return Center(
              child: Text(
            'Nenhuma bebida encontrada\nToque no botão abaixo para carregar as bebidas',
            textAlign: TextAlign.center,
          ));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemBuilder: (_, index) {
            if (list.length > index) {
              final beer = list[index];
              return _buildItemList(beer);
            } else {
              return _buildBottomLoader();
            }
          },
          itemCount: list.length + 1,
          controller: _scrollController,
        );
      },
    );
  }

  Widget _buildItemList(Beer entity) {
    return GestureDetector(
      onTap: () => _bloc.dispatchEvent(Details(entity: entity)),
      child: Card(
        elevation: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              child: Image.network(entity.imageUrl!),
            ),
            const SizedBox(height: 20),
            Text(
              entity.name ?? '--',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return LinearProgressIndicator(color: Colors.red,);
  }

  Widget _buildBottomLoader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
