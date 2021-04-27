enum TaskStatus { initial, loading, success, error }

class Task<T> {
  final TaskStatus status;
  final T? data;
  final String? message;
  final Object? error;

  Task({
    required this.status,
    this.data,
    this.message,
    this.error,
  });
}
