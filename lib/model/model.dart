/// Base Result class
/// [S] represents the type of the success value
/// [E] should be [Exception] or a subclass of it
sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final Exception exception;
}