import 'package:app_miles/app_miles.dart';

class FlatButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color color;
  final Color? textColor;
  final double? border;

  const FlatButtonWidget({
    required this.onPressed,
    required this.text,
    this.color = Colors.black54,
    this.textColor = Colors.white,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border ?? 16.0),
        ),
        color: color,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
