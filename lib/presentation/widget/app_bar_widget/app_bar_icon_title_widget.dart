import 'package:app_miles/presentation/widget/app_bar_widget/arrow_back_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarIconTitleWidget extends StatelessWidget {
  final String? title;

  const AppBarIconTitleWidget({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ArrowBackWidget(),
        Text(
          title!,
          style:
              Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16.0),
        ),
        // hackzinho para posicionar o texto 'Login no centro'
        const Text(
          'Login',
          style: TextStyle(color: Colors.transparent),
        )
      ],
    );
  }
}
