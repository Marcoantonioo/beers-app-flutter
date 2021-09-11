import 'package:beers_app/domain/beer.dart';

class HomeEvent {
  HomeEvent();
}

class LoadAll extends HomeEvent {
  @override
  String toString() => 'Load All';
}

class Details extends HomeEvent {
  final Beer? entity;

  Details({required this.entity});
}
