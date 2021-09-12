import 'package:app_miles/app_miles.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage._();

  @override
  _HomePageState createState() => _HomePageState();

  static Widget create(BuildContext context) {
    return const HomePage._();
  }
}

@override
_HomePageState createState() => _HomePageState();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ha"),
      ),
    );
  }
}
