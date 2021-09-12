import 'package:app_miles/core/http/request_mode.dart';

abstract class HttpRemote {
  Future<Map<String, dynamic>> doRequest(RequestModel request);
}
