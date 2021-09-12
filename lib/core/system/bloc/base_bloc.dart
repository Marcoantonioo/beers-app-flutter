import 'package:meta/meta.dart';

abstract class BaseBloc {
  @protected
  @mustCallSuper
  void dispose();
}
