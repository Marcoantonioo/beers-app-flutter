import 'package:app_miles/app_miles.dart';
import 'package:app_miles/core/local_store/local_store.dart';

class SessionDao extends SessionStore {
  final LocalStore? _localStore;

  SessionDao({@required LocalStore? localStore})
      : _localStore = localStore,
        assert(localStore != null);

  static const key = 'session';

  @override
  Future<SessionModel?> getSession() {
    var session = _localStore!.getValue<String?>(key).then((session) {
      return session == null ? null : SessionModel.fromJson(session);
    });

    return session;
  }

  @override
  Future<void> saveSession(SessionModel entity) =>
      _localStore!.setValue<dynamic>(key, entity.toJson());

  @override
  Future<void> cleanSession() => _localStore!.setValue<dynamic>(key, null);
}
