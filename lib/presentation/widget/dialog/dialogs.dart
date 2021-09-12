import 'package:app_miles/app_miles.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .40,
                height: MediaQuery.of(context).size.height * .20,
                decoration: const ShapeDecoration(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    LoadingWidget(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
