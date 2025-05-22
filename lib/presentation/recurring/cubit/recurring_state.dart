import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/task.dart';

enum RecurringStatus { initial, loading, success, failure }

class RecurringState extends Equatable{

  RecurringState({this.status = RecurringStatus.initial, List<Task>? sortedTasks, List<Event>? sortedEvents}): sortedEvents = sortedEvents ?? [], sortedTasks = sortedTasks ?? [];

  final RecurringStatus status;
  final List<Task> sortedTasks;
  final List<Event> sortedEvents;

  RecurringState copyWith({
    RecurringStatus? status,
    List<Task>? sortedTasks,
    List<Event>? sortedEvents,
}) => RecurringState(
    status: status ?? this.status,
    sortedEvents: sortedEvents ?? this.sortedEvents,
    sortedTasks: sortedTasks ?? this.sortedTasks,
  );

  @override
  List<Object?> get props => [
        status,
        sortedTasks,
        sortedEvents,
  ];

}