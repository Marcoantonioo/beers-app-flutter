import 'package:app_miles/app_miles.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'App Miles',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              LoadingWidget()
            ],
          ),
        ),
      ),
    );
  }
}
