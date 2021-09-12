import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool enableBackButton;

  const MyAppBar({
    required this.title,
    this.enableBackButton = false,
  }) : assert(title != null);

  @override
  My_AppBarState createState() => My_AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class My_AppBarState extends State<MyAppBar> {
  String? get title => widget.title;
  bool get enableBackButton => widget.enableBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title!),
        centerTitle: true,
        leading: enableBackButton
            ? GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () => Navigator.pop(context),
              )
            : Container());
  }
}
