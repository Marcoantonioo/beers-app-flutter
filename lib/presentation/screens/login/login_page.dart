import 'package:app_miles/app_miles.dart';
import 'package:app_miles/presentation/widget/flat_button/flat_button_widget.dart';
import 'package:app_miles/presentation/widget/form/text_field_login_passoword_widget.dart';
import 'package:app_miles/presentation/widget/form/text_field_login_widget.dart';

class LoginPage extends StatefulWidget {
  static const route = LoginBloc.route;

  const LoginPage._();

  @override
  _LoginPageState createState() => _LoginPageState();

  static Widget create(BuildContext context) {
    return Provider<LoginBloc>(
      create: (_) => CoreDI.resolve<LoginBloc>(),
      dispose: (_, value) => value.dispose(),
      child: const LoginPage._(),
    );
  }
}

class _LoginPageState extends BaseStateCard<LoginPage> {
  LoginBloc get _bloc => Provider.of<LoginBloc>(context, listen: false);

  @override
  AppBarIconTitleWidget getAppBar() {
    return const AppBarIconTitleWidget(title: 'Login');
  }

  @override
  List<Widget> getChilds() {
    return [
      _buildTextFieldEmail(),
      _buildTextFiedlPassowrd(),
      const SizedBox(height: 10),
      _buildButtonLogin(),
    ];
  }

  Widget _buildTextFieldEmail() {
    return TextFieldLoginWidget(
      stream: _bloc.streamOf<String>(key: LoginKey.username),
      onChanged: (value) => _bloc.dispatchOn(value, key: LoginKey.username),
      hint: 'E-mail',
    );
  }

  Widget _buildTextFiedlPassowrd() {
    return TextFieldLoginPassowrdWidget(
      stream: _bloc.streamOf<String>(key: LoginKey.password),
      onChanged: (value) => _bloc.dispatchOn(value, key: LoginKey.password),
      visibilityStream: _bloc.streamOf<bool>(key: LoginKey.visibilityPassword),
      onTapIcon: (visible) =>
          _bloc.dispatchOn(visible, key: LoginKey.visibilityPassword),
    );
  }

  Widget _buildButtonLogin() {
    return FlatButtonWidget(
      color: Colors.black54,
      border: 8,
      text: 'Entrar',
      onPressed: () => _bloc.event(DoLogin()),
    );
  }
}
