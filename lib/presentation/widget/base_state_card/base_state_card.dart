import 'package:app_miles/presentation/widget/app_bar_widget/app_bar_icon_title_widget.dart';
import 'package:app_miles/presentation/widget/dismiss_keyboard/dismiss_keyboard_on_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///  Base State para as card's contidas na tela de boas vindas e login
abstract class BaseStateCard<T extends StatefulWidget> extends State<T> {
  bool get hasAppBar => getAppBar() != null;

  List<Widget> getChilds();
  AppBarIconTitleWidget? getAppBar() => null;

  @override
  Widget build(BuildContext context) {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_welcome_page_2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black38,
              Color(0xff3e87a5),
            ],
          ),
        ),
        child: DismissKeyboardOnTap(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  hasAppBar ? getAppBar()! : const SizedBox.shrink(),
                  Expanded(
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/logo_app_black.png',
                                    height: MediaQuery.of(context).size.height *
                                        .20,
                                  ),
                                  const SizedBox(height: 20),
                                  ...getChilds()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
