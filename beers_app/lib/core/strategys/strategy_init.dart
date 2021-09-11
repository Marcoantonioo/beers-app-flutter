/// Strategia adotada para ser executada no inicio
/// da aplicação, para executar tarefas cruciais para
/// o funcionamente do app
abstract class StrategyInit {
  Iterable<InitAction> get functionsToExecute;
}

typedef void InitAction();
