abstract class ApiBaseBlocState {
  const ApiBaseBlocState();
}

class ApiBaseBlocInitialState extends ApiBaseBlocState {}

class ApiErrorState extends ApiBaseBlocState {


  ApiErrorState();
}

class ApiLoadingState extends ApiBaseBlocState {}

class ApiLoadedState extends ApiBaseBlocState {}
