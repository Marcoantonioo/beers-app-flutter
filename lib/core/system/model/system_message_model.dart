class SysMessageModel {
  final String? key;
  final Map<dynamic, dynamic>? params;
  String? dialogMessage;

  SysMessageModel({this.key, this.params, this.dialogMessage});
}

class SysErrorMessageModel extends SysMessageModel {
  static const keyValue = 'Error';
  SysErrorMessageModel(String message)
      : super(
          key: keyValue,
          params: <String, dynamic>{'message': message},
        );
}

class SysSuccessMessageModel extends SysMessageModel {
  static const keyValue = 'Success';
  SysSuccessMessageModel(String message)
      : super(
          key: keyValue,
          params: <String, dynamic>{'message': message},
        );
}

class SysDialogMessageModel extends SysMessageModel {
  static const keyValue = 'Loading';

  SysDialogMessageModel(String message)
      : super(key: keyValue, dialogMessage: message);
}

class SysDismissDialogMessageModel extends SysMessageModel {
  static const keyValue = 'Dismiss';

  SysDismissDialogMessageModel()
      : super(
          key: keyValue,
        );
}
