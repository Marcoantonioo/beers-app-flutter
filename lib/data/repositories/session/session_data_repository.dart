import 'package:app_miles/app_miles.dart';

class SessionDataRepository implements SessionRepository {
  final SessionStore? _dao;

  SessionDataRepository({
    @required SessionStore? dao,
  })  : _dao = dao,
        assert(dao != null);

  @override
  Future<void> cleanSession() => _dao!.cleanSession();

  @override
  Future<SessionModel?> getSession() => _dao!.getSession();

  @override
  Future<void> saveSession(SessionModel session) => _dao!.saveSession(session);
}