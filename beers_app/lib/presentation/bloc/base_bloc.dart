import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/material.dart';

/// TODO implementar serviço de navegação
abstract class BaseBloc<Event> extends FancyDelegate {
  BaseBloc() {
    // init da criação do objeto
    init();
  }

  @protected
  void init() {}

  @protected
  void handleEvent(Event event);
  void dispatchEvent(Event event);

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
