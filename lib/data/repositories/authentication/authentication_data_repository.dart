import 'package:app_miles/data/data.dart';
import 'package:app_miles/domain/model/credential_model.dart';
import 'package:app_miles/domain/model/response_model.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationDataRepository implements AuthenticationRepository {
  final AuthenticationStore? _remote;

  AuthenticationDataRepository({
    @required AuthenticationStore? remote,
  })  : _remote = remote,
        assert(remote != null);

  @override
  Future<ResponseModel> login(CredencialModel entity) => _remote!.login(entity);

  @override
  Future<ResponseModel> logout() => _remote!.logout();
}
