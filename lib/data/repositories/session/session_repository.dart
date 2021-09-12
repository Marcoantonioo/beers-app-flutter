import 'package:app_miles/app_miles.dart';

abstract class SessionRepository {
  Future<SessionModel?> getSession();
  Future<void> saveSession(SessionModel session);
  Future<void> cleanSession();
}
