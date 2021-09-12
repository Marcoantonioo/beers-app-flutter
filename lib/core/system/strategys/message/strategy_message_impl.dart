import 'package:another_flushbar/flushbar.dart';
import 'package:app_miles/core/system/model/system.dart';
import 'package:app_miles/core/system/strategys/message/strategy_message.dart';
import 'package:app_miles/presentation/widget/dialog/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StrategyMessageImpl implements StrategyMessage {
  final BuildContext context;
  @override
  final Stream<SysMessageModel> sysMessage;

  StrategyMessageImpl(this.context, this.sysMessage);

  @override
  void showSuccessMessage(SysSuccessMessageModel message) {
    _showSnackBar(
      message: message.params!['message'] as String,
      backgroundColor: Colors.green,
      backgroundColorButton: Colors.green[700]!,
    );
  }

  @override
  void showErrorMessage(SysErrorMessageModel message) {
    _showSnackBar(
      message: message.params!['message'] as String,
      backgroundColor: Colors.red,
      backgroundColorButton: Colors.red[700]!,
    );
  }

  void _showSnackBar({
    String? message,
    Color? backgroundColor,
    Color? backgroundColorButton,
    Color? backgroundColorMessage,
  }) {
    Future.delayed(const Duration(milliseconds: 100), () {
      Flushbar(
        message: message,
        backgroundColor: backgroundColor!,
        duration: Duration(seconds: 3),
      )..show(context);
    });
  }

  @override
  void showLoadingDialog(SysDialogMessageModel dialog) {
    Dialogs.showLoadingDialog(context, dialog.dialogMessage!);
  }

  @override
  void dismissLoagindDialog(SysDismissDialogMessageModel dimiss) {
    Navigator.pop(context);
  }
}
