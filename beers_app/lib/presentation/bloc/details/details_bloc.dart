import 'package:beers_app/core/sys/bloc/sys_bloc.dart';
import 'package:beers_app/presentation/bloc/base_bloc.dart';
import 'package:beers_app/presentation/bloc/details/details_event.dart';

class DetailsBloc extends BaseBloc<DetailsEvent> {
  DetailsBloc({
    required SysBloc sysBloc,
  }) : super(sysBloc: sysBloc);

  @override
  void dispatchEvent(DetailsEvent event) => dispatchOn<DetailsEvent>(event);

  @override
  void handleEvent(DetailsEvent event) {
    // TODO: implement handleEvent
  }
}

enum DetailsKey {
  EXPANDED
}
