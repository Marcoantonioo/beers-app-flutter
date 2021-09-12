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

  late TextEditingController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _controller = TextEditingController();
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: MyAppBar(title: 'Beers'),
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildTextFieldSearch(),
          StreamBuilder<bool>(
            stream: _bloc.streamOf<bool>(key: BaseBlocKey.LOADING),
            builder: (_, snapshot) {
              final isLoading = snapshot.data ?? false;

              if (isLoading) {
                return _buildLoader();
              } else {
                return Expanded(child: _buildList());
              }
            },
          ),
        ],
      ),
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
              crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3),
          itemBuilder: (_, index) {
            if (list.length > index) {
              final beer = list[index];
              return _buildItemList(beer);
            } else {
              return StreamBuilder<String>(
                  stream: _bloc.streamOf<String>(key: HomeKey.SEARCH),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return _buildBottomLoader();
                    } else
                      return Container();
                  });
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
          elevation: 1,
          child: _wrapWithPadding(
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: Image.network(entity.imageUrl!),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Text(
                    entity.name ?? '--',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildTextFieldSearch() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: StreamBuilder<String>(
              stream: _bloc.streamOf<String>(key: HomeKey.SEARCH),
              builder: (context, snapshot) {
                final value = snapshot.data.toString();
                if (_controller.text.isEmpty && snapshot.hasData) {
                  _controller.text = value;
                }
                return TextFormField(
                  enableInteractiveSelection: false,
                  focusNode: FocusNode(),
                  onChanged: (value) =>
                      _bloc.dispatchOn<String>(value, key: HomeKey.SEARCH),
                  controller: _controller,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.search, size: 16, color: Colors.blue),
                      ),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Pesquisar por nomes de bebidas.',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusColor: Colors.white,
                      suffixStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(fontSize: 14)),
                );
              }),
        ));
  }

  Widget _wrapWithPadding(Widget child, {double paddingAll = 8.0}) {
    return Padding(
      padding: EdgeInsets.all(paddingAll),
      child: child,
    );
  }

  Widget _buildLoader() {
    return LinearProgressIndicator(
      color: Colors.red,
    );
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
