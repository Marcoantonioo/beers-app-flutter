import 'package:beers_app/core/sys/bloc/sys_bloc.dart';
import 'package:beers_app/core/sys/router/dispatcher.dart';
import 'package:beers_app/core/sys/router/dispatcher_impl.dart';
import 'package:get_it/get_it.dart';

class SysDI {
  static void registerAll(GetIt container) {
    container.registerSingleton<DispatchRouter>(DispatchRouterImpl()..init());
    container.registerLazySingleton(
      () => SysBloc(
        dispatchRouter: container.get(),
      ),
    );
  }
}
