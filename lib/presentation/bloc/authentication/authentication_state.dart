import 'package:app_miles/core/system/bloc/system_event.dart';

abstract class AuthenticationEvent extends SystemEvent {
  AuthenticationEvent();
}

class Initialize extends AuthenticationEvent {}
