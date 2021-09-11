import 'package:beers_app/di/application_di.dart';
import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/presentation/bloc/base_bloc.dart';
import 'package:beers_app/presentation/bloc/home/home_bloc.dart';
import 'package:beers_app/presentation/bloc/home/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TODO melhorar layout e implementar mais funcionalidades
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.dispatchEvent(LoadAll()),
        child: Icon(Icons.refresh),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Beers'),
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
        final list = snapshot.data ?? [];

        if (list.isEmpty) {
          return Center(
              child: Text(
            'Nenhuma bebida encontrada\nToque no botão abaixo para carregar as bebidas',
            textAlign: TextAlign.center,
          ));
        }

        return ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (_, index) => _buildItemList(list[index]),
            separatorBuilder: (_, index) => Divider(),
            itemCount: list.length);
      },
    );
  }

  Widget _buildItemList(Beer entity) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          child: Image.network(entity.imageUrl!),
        ),
        Text(entity.name ?? "--"),
      ],
    );
  }

  Widget _buildLoader() {
    return Center(child: CircularProgressIndicator());
  }
}
