import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/task.dart';

enum MatrixStatus { initial, loading, success, failure }

class MatrixState extends Equatable{

  MatrixState({
    this.status = MatrixStatus.initial,
    this.tasks = const [],
});

  final MatrixStatus status;
  final List<Task>? tasks;

  MatrixState copyWith({
    MatrixStatus? status,
    List<Task>? tasks,
    List<Event>? events
}) => MatrixState(
    status: status ?? this.status,
    tasks: tasks ?? this.tasks,
  );

  @override
  List<Object?> get props => [
        status,
        tasks,
  ];

}