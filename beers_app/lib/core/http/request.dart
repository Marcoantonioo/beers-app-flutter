import 'package:flutter/cupertino.dart';

class RequestModel {
  final String? endpoint;
  final Method? method;
  final dynamic params;
  final dynamic queryParameters;

  RequestModel({
    @required this.endpoint,
    @required this.method,
    this.params,
    this.queryParameters,
  })  : assert(endpoint != null),
        assert(method != null);

  String getMethodString() {
    if (Method.POST == method) {
      return "POST";
    } else if (Method.GET == method) {
      return "GET";
    } else if (Method.PUT == method) {
      return "PUT";
    } else if (Method.DELETE == method) {
      return "DELETE";
    }

    throw UnimplementedError("Não encontrado o Method");
  }
}

enum Method { POST, GET, PUT, DELETE }