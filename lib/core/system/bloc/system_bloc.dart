import 'package:app_miles/core/system/bloc/base_bloc.dart';
import 'package:app_miles/core/system/model/system_message_model.dart';
import 'package:app_miles/core/system/model/system_navigate_model.dart';
import 'package:rxdart/rxdart.dart';

class SystemBloc implements BaseBloc {
  final _sysMessageController = BehaviorSubject<SysMessageModel>();
  Function(SysMessageModel) get dispatchSysMessage =>
      _sysMessageController.sink.add;
  Stream<SysMessageModel> get sysMessage => _sysMessageController.stream;

  final _sysNavigateController = BehaviorSubject<SysNavigateModel>();
  Function(SysNavigateModel) get dispatchSysNavigate =>
      _sysNavigateController.sink.add;
  Stream<SysNavigateModel> get sysNavigate => _sysNavigateController.stream;

  @override
  void dispose() {
    _sysMessageController.close();
    _sysNavigateController.close();
  }
}
