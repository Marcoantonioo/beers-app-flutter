///Classe base para o sistema de rotas, é extendida
///pela [RouteForwardModel] e pela [RouteBackModel], estas
///são usadas para retroceder e avançar na navegação
class BaseRoute {
  final String? route;
  final Object? routeParameter;

  const BaseRoute({required this.route, this.routeParameter});
}