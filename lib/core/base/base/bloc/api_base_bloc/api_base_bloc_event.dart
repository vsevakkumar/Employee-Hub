abstract class ApiBaseBlocEvents {}

class LoadApiEvent extends ApiBaseBlocEvents {}

class ErrorApiEvent extends ApiBaseBlocEvents {
  ErrorApiEvent();
}

class LoadedApiEvent extends ApiBaseBlocEvents {}
