import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrowBackWidget extends StatelessWidget {
  final Function? onTap;
  final Color? background;

  const ArrowBackWidget({this.onTap, this.background});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 20,
          color: background ?? Colors.black54,
        ),
        onPressed: () {
          onTap ?? Navigator.pop(context);
        });
  }
}
