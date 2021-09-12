import 'package:app_miles/core/system/bloc/system_event.dart';

abstract class LoginEvent extends SystemEvent {
  LoginEvent();
}

class DoLogin extends LoginEvent {
  @override
  String toString() => 'efetuando login';
}
