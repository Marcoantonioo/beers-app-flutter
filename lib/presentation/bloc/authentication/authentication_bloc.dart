import 'package:app_miles/app_miles.dart';
import 'package:app_miles/constants/constants.dart';
import 'package:app_miles/core/system/bloc/base_screen_bloc.dart';
import 'package:app_miles/core/system/bloc/system.dart';

class AuthenticationBloc extends BaseScreenBloc {
  late SessionRepository? _sessionRepository;

  AuthenticationBloc({
    required SessionRepository? sessionRepository,
    required SystemBloc? systemBloc,
  })  : _sessionRepository = sessionRepository,
        assert(sessionRepository != null),
        assert(systemBloc != null),
        super(systemBloc: systemBloc);

  @override
  void init() {
    _inicializing();
    addSysMessageListener(Constansts.loggedIn, (_) => _dispatchPage());
    addSysMessageListener(Constansts.loggedOut, (_) => _dispatchPage());
  }

  @override
  void handleEvent(SystemEvent event) {
    switch (event.runtimeType) {
      case Initialize:
        _inicializing();
        break;
      default:
    }
  }

  void _dispatchPage() {
    _sessionRepository?.getSession().then((session) {
      if (session != null && session.jwt?.token != null) {
        _loggedIn(session);
      } else {
        _loggedOut();
      }
    });
  }

  void _loggedIn(SessionModel session) {
    dispatchOn<AuthenticationState>(LoggedIn(session),
        key: AuthenticationKey.authenticationState);
  }

  void _loggedOut() {
    dispatchOn<AuthenticationState>(LoggedOut(),
        key: AuthenticationKey.authenticationState);
  }

  void _inicializing() {
    dispatchOn<AuthenticationState>(Initializing(),
        key: AuthenticationKey.authenticationState);
    _dispatchPage();
  }
}

enum AuthenticationKey {
  authenticationState,
}
