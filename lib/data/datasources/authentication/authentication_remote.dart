import 'package:app_miles/core/http/http.dart';
import 'package:app_miles/data/data.dart';
import 'package:app_miles/data/datasources/authentication/json_exemple.dart';
import 'package:app_miles/domain/model/credential_model.dart';
import 'package:app_miles/domain/model/response_model.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationRemote implements AuthenticationStore {
  final HttpRemote? _httpRemote;

  AuthenticationRemote({
    @required HttpRemote? httpRemote,
  })  : _httpRemote = httpRemote,
        assert(httpRemote != null);

  static const _endpoint = 'login';
  @override
  Future<ResponseModel> login(CredencialModel credentials) async {
    /// fake json autenticação
    var mapped = ResponseModel.fromMap(ExemploJson().json);

    return mapped;
  }

  //=> _httpRemote!
  //     .doRequest(
//        RequestModel(
  //         params: credentials.toJson(),
  ////         endpoint: _endpoint,
  //        method: Method.POST,
  ///       ),
  //     )
  //     .then((response) => ResponseModel.fromMap(response));

  @override
  Future<ResponseModel> logout() => _httpRemote!
      .doRequest(
        RequestModel(
          endpoint: '$_endpoint/logout',
          method: Method.POST,
        ),
      )
      .then((response) => ResponseModel.fromMap(response));
}
