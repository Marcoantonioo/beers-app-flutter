import 'package:app_miles/app_miles.dart';
import 'package:app_miles/core/system/bloc/system.dart';
import 'package:app_miles/data/data.dart';
import 'package:app_miles/domain/model/credential_model.dart';
import 'package:app_miles/presentation/bloc/login/login_event.dart';

class LoginBloc extends BaseScreenBloc {
  static const String route = '/login';
  late AuthenticationRepository? _authenticationRepository;
  late SessionRepository? _sessionRepository;

  LoginBloc({
    required AuthenticationRepository? authenticationRepository,
    required SessionRepository? sessionRepository,
    required SystemBloc? systemBloc,
  })  : _authenticationRepository = authenticationRepository,
        _sessionRepository = sessionRepository,
        assert(authenticationRepository != null),
        assert(sessionRepository != null),
        super(systemBloc: systemBloc!);

  @override
  void init() {}

  @override
  void handleEvent(SystemEvent event) {
    switch (event.runtimeType) {
      case DoLogin:
        _doActionLogin();
        break;
    }
  }

  String? get _username => map[LoginKey.username];
  String? get _password => map[LoginKey.password];

  void _doActionLogin() {
    /// definindo a mensagem do dialog de loading
    dialogMessage = "Aguarde, realizando autenticação.";
    final _credential =
        CredencialModel(username: _username, password: _password);

    if (_isFieldsValid(_credential)) {
      doOnlineAction(action: () async {
        /// tirar esse delay aqui dps, apenas para testes.
        await Future.delayed(Duration(seconds: 2), () {
          _authenticationRepository!.login(_credential).then((response) async {
            if (response.isSuccess()) {
              await _saveSession(response);
              navigateForward('/home');
              showSuccess(response.message!);
            } else {
              showError(response.message!);
            }
          });
        });
      });
    } else {
      showError("Preencha os campos");
    }
  }

  Future<SessionModel> _saveSession(ResponseModel response) async {
    SessionModel session = SessionModel();
    Jwt jwt = Jwt.fromMap(response.params['jwt']);
    UserModel user = UserModel.fromMap(response.params['user']);

    /// copyWith não esta bombando ver dps
    session.jwt = jwt;
    session.user = user;

    await _sessionRepository?.saveSession(session);
    return session;
  }

  bool _isFieldsValid(CredencialModel? credenciais) {
    if (credenciais?.username == null || credenciais!.username!.isEmpty) {
      return false;
    }
    if (credenciais.password == null || credenciais.password!.isEmpty) {
      return false;
    }
    return true;
  }
}

enum LoginKey {
  username,
  password,
  visibilityPassword,
}
