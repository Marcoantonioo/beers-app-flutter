import 'package:app_miles/core/system/bloc/system_bloc.dart';
import 'package:get_it/get_it.dart';

class SystemDI {
  static void registerAll(GetIt container) {
    container.registerSingleton(SystemBloc());
  }
}
