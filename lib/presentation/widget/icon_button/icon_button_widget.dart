import 'package:app_miles/app_miles.dart';

class IconButtonWidget extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color? color;
  final double? size;

  const IconButtonWidget({
    required this.onPressed,
    required this.icon,
    this.color,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Icon(
        icon,
        size: size ?? 24,
        color: color ?? Colors.black54,
      ),
    );
  }
}
