import 'package:app_miles/app_miles.dart';

abstract class SessionStore {
  Future<SessionModel?> getSession();
  Future<void> saveSession(SessionModel entity);
  Future<void> cleanSession();
}