import 'package:app_miles/app_miles.dart';

abstract class AuthenticationState {
  AuthenticationState();
}

class Initializing extends AuthenticationState {}

class LoggedIn extends AuthenticationState {
  final SessionModel session;

  LoggedIn(this.session);
}

class LoggedOut extends AuthenticationState {}
