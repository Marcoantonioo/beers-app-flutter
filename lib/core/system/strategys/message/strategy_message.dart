import 'package:app_miles/core/system/model/system.dart';

abstract class StrategyMessage {
  Stream<SysMessageModel> get sysMessage;
  void showSuccessMessage(SysSuccessMessageModel message);
  void showErrorMessage(SysErrorMessageModel message);
  void showLoadingDialog(SysDialogMessageModel dialog);
  void dismissLoagindDialog(SysDismissDialogMessageModel dismiss);
}
