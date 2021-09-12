import 'package:beers_app/di/application_di.dart';
import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/presentation/bloc/details/details_bloc.dart';
import 'package:beers_app/presentation/widget/app_bar.dart';
import 'package:beers_app/presentation/widget/expanded_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  static const route = "/details";

  const DetailsPage._();

  static Widget create(BuildContext context) {
    return Provider<DetailsBloc>(
      create: (_) => ApplicationDI.resolve<DetailsBloc>(),
      dispose: (_, value) => value.dispose(),
      child: const DetailsPage._(),
    );
  }

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Beer get _beer => ModalRoute.of(context)!.settings.arguments as Beer;
  DetailsBloc get _bloc => Provider.of<DetailsBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detalhes',
        enableBackButton: true,
      ),
      body: ListView(
        children: [
          _buildImage(),
          _buildContentBeer(),
        ],
      ),
    );
  }

  Widget _buildContentBeer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName(),
          _buildTagLine(),
          const SizedBox(height: 10),
          _buildFirstBrewed(),
          ExpandedWidget(
            stream: _bloc.streamOf(key: DetailsKey.EXPANDED),
            dispatchOnExpanded: () =>
                _bloc.dispatchOn(_beer.id!, key: DetailsKey.EXPANDED),
            dispatchOn: () => _bloc.dispatchOn(0, key: DetailsKey.EXPANDED),
            objectId: _beer.id,
            title: 'Descrição da bebida',
            childExpanded: Text(_beer.description!),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstBrewed() {
    return Text(
      'Fabricada em:\n${_beer.firstBrewed ?? '--'}',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildName() {
    return Text(
      '${_beer.name ?? '--'}',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTagLine() {
    return Text(
      '${_beer.tagline ?? '--'}',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      color: Colors.grey[200],
      height: MediaQuery.of(context).size.height / 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.network(
          _beer.imageUrl ?? '--',
        ),
      ),
    );
  }
}
