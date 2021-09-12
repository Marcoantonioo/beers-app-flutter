import 'package:app_miles/app_miles.dart';
import 'package:app_miles/presentation/screens/home/home_page.dart';
import 'package:app_miles/presentation/screens/login/login_page.dart';
import 'package:app_miles/presentation/screens/spash/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class RootWidget extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Provider<AuthenticationBloc>(
      create: (_) => CoreDI.resolve<AuthenticationBloc>(),
      dispose: (_, value) => value.dispose(),
      child: RootWidget(),
    );
  }

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  AuthenticationBloc get _bloc => Provider.of(context, listen: false);

  @override
  void initState() {
    _bloc.event(Initialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticationState>(
      stream: _bloc.streamOf<AuthenticationState>(
          key: AuthenticationKey.authenticationState),
      builder: (_, snapshot) {
        final state = snapshot.data;
        switch (state.runtimeType) {
          case Initializing:
            return SplashScreen();
          case LoggedIn:
            return HomePage.create(context);
          case LoggedOut:
            return LoginPage.create(context);
          default:
            return SplashScreen();
        }
      },
    );
  }
}
