import 'package:beers_app/core/sys/bloc/sys_bloc.dart';
import 'package:beers_app/core/sys/router/route.dart';
import 'package:beers_app/core/sys/router/route_forward.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/material.dart';

abstract class BaseBloc<Event> extends FancyDelegate {
  final SysBloc sysBloc;
  BaseBloc({required this.sysBloc}) {
    // init da criação do objeto
    init();
  }

  @protected
  void init() {}

  @protected
  void handleEvent(Event event);
  void dispatchEvent(Event event);

  /// Router
  void navigateForward<T>(
    String route, {
    dynamic routeParameter,
    CallbackRoute<T>? onComplete,
  }) =>
      sysBloc.dispatchRoute(
        SysRoute(
          routeForward: RouteForward(
            route,
            routeParameter: routeParameter,
            onComplete: (data) => onComplete?.call(data as T),
          ),
        ),
      );

  void navigatePop([Object? routeParameter]) =>
      sysBloc.dispatchRoute(SysRoute.pop(routeParameter));

  void navigateToRoot() => sysBloc.dispatchRoute(SysRoute.toRoot());

  Future<void> doOnlineAction({
    required Function action,
    Function? onError,
    Function? onFinish,
  }) async {
    try {
      dispatchOn<bool>(true, key: BaseBlocKey.LOADING);
      await action.call();
    } on Exception catch (error, _) {
      onError?.call();
    } finally {
      dispatchOn<bool>(false, key: BaseBlocKey.LOADING);
      onFinish?.call();
    }
  }
}

enum BaseBlocKey {
  LOADING,
}
