import 'package:flutter/cupertino.dart';

class DismissKeyboardOnTap extends StatelessWidget {
  final Widget? child;

  const DismissKeyboardOnTap({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
