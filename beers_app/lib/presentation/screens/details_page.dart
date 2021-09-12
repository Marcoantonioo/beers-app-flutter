import 'package:beers_app/domain/beer.dart';
import 'package:beers_app/presentation/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  static const route = "/details";

  const DetailsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return DetailsPage();
  }

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Beer get _beer => ModalRoute.of(context)!.settings.arguments as Beer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detalhes',
        enableBackButton: true,
      ),
      body: Center(
        child: Text(_beer.name ?? "--"),
      ),
    );
  }
}
