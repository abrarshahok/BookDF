abstract class LoadState {}

class InitialState extends LoadState {}

class LoadingState extends LoadState {}

class SuccessState<T> extends LoadState {
  final T data;

  SuccessState(this.data);
}

class ErrorState extends LoadState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
