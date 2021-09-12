import 'dart:async';
import 'package:app_miles/core/system/bloc/system.dart';
import 'package:app_miles/core/system/bloc/system_bloc.dart';
import 'package:app_miles/core/system/model/system_message_model.dart';
import 'package:app_miles/core/system/model/system_navigate_model.dart';
import 'package:app_miles/core/system/navigate/navigate.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseScreenBloc extends FancyDelegate {
  /// Dependências
  final SystemBloc? _systemBloc;

  /// mensagem que o dialog de loading irá exibir
  /// ao usuário, podendo ter sobrescrita nos blocs
  var dialogMessage = "Aguarde um momento.";

  /// Subs
  late StreamSubscription? _subsEvent;
  late List<StreamSubscription> _allSubsSysMessage = [];

  /// Construtor
  BaseScreenBloc({
    @required SystemBloc? systemBloc,
  })  : _systemBloc = systemBloc,
        assert(systemBloc != null) {
    _subsEvent = _event.listen(handleEvent);
    init();
  }

  /// Init
  @protected
  void init();

  @protected
  void handleEvent(SystemEvent event);

  /// ============ STREAMS ============
  final _loadingController = BehaviorSubject<bool>();
  Function(bool) get onLoadingChange => _loadingController.sink.add;
  Stream<bool> get isLoading => _loadingController.stream;

  final _errorController = BehaviorSubject<bool>();
  Function(bool) get onErrorChange => _errorController.sink.add;
  Stream<bool> get hasError => _errorController.stream;

  final _eventController = BehaviorSubject<SystemEvent>();
  Function(SystemEvent) get event => _eventController.sink.add;
  Stream<SystemEvent> get _event => _eventController.stream;

  /// ============ NAVEGAÇÃO ============
  void navigateForward<T>(
    String route, {
    Object? parameter,
    CallbackRoute<T>? onComplete,
    bool popAndGo = false,
  }) {
    _systemBloc?.dispatchSysNavigate(
      SysNavigateModel(
        navigateForward: NavigateForwardModel<T>(
          route: route,
          parameter: parameter,
          onComplete: onComplete != null
              ? (Object? onCompleteData) {
                  onComplete(onCompleteData as T);
                }
              : null,
        ),
        navigateBack: popAndGo ? NavigateBackModel() : null,
      ),
    );
  }

  void navigateBackAndForward<T>({
    String? forwardRoute,
    String? backRoute,
    Object? parameter,
    CallbackRoute<T>? onComplete,
  }) {
    _systemBloc?.dispatchSysNavigate(
      SysNavigateModel(
        navigateBack: NavigateBackModel(route: backRoute!),
        navigateForward: NavigateForwardModel<T>(
          route: forwardRoute!,
          parameter: parameter,
          onComplete: onComplete != null
              ? (Object? onCompleteData) {
                  onComplete(onCompleteData as T);
                }
              : null,
        ),
      ),
    );
  }

  void navigatePop({Object? parameter}) {
    _systemBloc
        ?.dispatchSysNavigate(SysNavigateModel.pop(parameter: parameter!));
  }

  void navigateToRoot() {
    _systemBloc?.dispatchSysNavigate(SysNavigateModel.toRoot());
  }

  /// ============ MENSAGENS ============
  void showSuccess(String message) {
    _systemBloc?.dispatchSysMessage(
      SysSuccessMessageModel(message),
    );
  }

  void showError(String message) {
    _systemBloc?.dispatchSysMessage(
      SysErrorMessageModel(message),
    );
  }

  void showLoadingDialog() {
    _systemBloc?.dispatchSysMessage(
      SysDialogMessageModel(dialogMessage),
    );
  }

  void dismisLoadingDialog() {
    _systemBloc?.dispatchSysMessage(
      SysDismissDialogMessageModel(),
    );
  }

  void dispatchMessage(String key, {Map<String, dynamic>? params}) {
    _systemBloc?.dispatchSysMessage(
      SysMessageModel(
        key: key,
        params: params!,
      ),
    );
  }

  void addSysMessageListener(
      String key, Function(SysMessageModel) whenMessageDispatch) {
    final streamSubs = _systemBloc!.sysMessage
        .where((message) => message.key == key)
        .listen(whenMessageDispatch);

    _allSubsSysMessage.add(streamSubs);
  }

  /// ============ ONLINE ACTION ============
  Future<void> doOnlineAction({
    Function? action,
    Function? onError,
    Function? onFinish,
    bool withLoading = true,
    bool showMessageWithoutInternet = true,
  }) async {
    try {
      if (isNotDisposed()) {
        if (withLoading) {
          onLoadingChange(true);
          showLoadingDialog();
        }
        onErrorChange(false);
        await action?.call();
      }
    } on Exception catch (error, _) {
      if (isNotDisposed()) {
        onErrorChange(true);
        await onError?.call();
        if (showMessageWithoutInternet) {
          showError('Falha na comunicação com o servidor.');
        }
      }
    } finally {
      if (isNotDisposed()) {
        await onFinish?.call();
      }
      if (withLoading) {
        onLoadingChange(false);
        dismisLoadingDialog();
      }
    }
  }

  bool isNullOrEmpty(dynamic value) {
    if (value is String?) {
      return value == null || value.isEmpty;
    }
    return value == null;
  }

  /// ============ DISPOSE ============
  @protected
  bool _disposed = false;

  @protected
  bool isNotDisposed([Object? _]) {
    return !_disposed;
  }

  @override
  void dispose() {
    cleanAll();
    _disposed = true;
    _subsEvent?.cancel();
    _loadingController.close();
    _errorController.close();
    _eventController.close();
    Future.forEach(_allSubsSysMessage, (StreamSubscription subs) {
      subs.cancel();
    });
  }
}
