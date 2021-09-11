import 'package:beers_app/core/http/request.dart';

abstract class HttpRemote {
  Future<List<dynamic>> doRequest(RequestModel request);
}
