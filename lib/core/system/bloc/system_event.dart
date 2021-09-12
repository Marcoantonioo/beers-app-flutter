abstract class SystemEvent {}

class NavigateToRoot extends SystemEvent {}

class HideDialog extends SystemEvent {}

class Navigate extends SystemEvent {
  final String route;
  final dynamic parameter;

  Navigate(this.route, {this.parameter});
}

class NavigatePop extends SystemEvent {}
