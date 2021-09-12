import 'package:app_miles/core/system/model/system.dart';
import 'package:flutter/material.dart';

abstract class StrategyNavigate {
  Stream<SysNavigateModel> get sysNavigate;

  void onNavigate<T>(BuildContext context, SysNavigateModel sysNavigate);
}
