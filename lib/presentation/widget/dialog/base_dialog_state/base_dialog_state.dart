import 'package:app_miles/app_miles.dart';

abstract class BaseDialogState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerOpen;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controllerOpen = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controllerOpen,
      curve: Curves.elasticInOut,
    );

    _controllerOpen.addListener(() {
      setState(() {});
    });

    _controllerOpen.forward();
  }

  List<Widget> getHeader(Object title) {
    if (title is String) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const Divider(height: 0.0)
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: title as Widget,
        ),
        const Divider(height: 0.0)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: getContentChild(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getContentChild();

  @override
  void dispose() {
    super.dispose();
    _controllerOpen.dispose();
  }
}