import 'package:app_miles/domain/model/credential_model.dart';
import 'package:app_miles/domain/model/response_model.dart';

abstract class AuthenticationRepository {
  Future<ResponseModel> login(CredencialModel credentials);
  Future<ResponseModel> logout();
}
