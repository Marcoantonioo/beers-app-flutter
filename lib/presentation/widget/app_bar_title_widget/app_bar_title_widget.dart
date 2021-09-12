import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String? title;

  const AppBarTitleWidget({@required this.title}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff353244),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 14.0, right: 14.0, top: 8.0, bottom: 8.0),
        child: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
