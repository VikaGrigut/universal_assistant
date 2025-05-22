import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/repositories/event_repository.dart';
import 'package:universal_assistant/presentation/recurring/cubit/recurring_state.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../../domain/repositories/task_repository.dart';

class RecurringCubit extends Cubit<RecurringState>{

  final TaskRepository _taskRepository;
  final EventRepository _eventRepository;

  RecurringCubit({
    required TaskRepository taskRepository,
    required EventRepository eventRepository,
  })  : _taskRepository = taskRepository,
        _eventRepository = eventRepository,
        super(RecurringState());

  Future<void> fetchRecurring() async{
    emit(state.copyWith(status: RecurringStatus.loading));

    try {
      final allTasks = await _taskRepository.getAllTasks() ?? [];
      final allEvents = await _eventRepository.getAllEvents() ?? [];

      emit(state.copyWith(
        status: RecurringStatus.initial,
        sortedTasks: _sortTasks(allTasks),
        sortedEvents: _sortEvents(allEvents),
      ));
    } catch (_) {
      emit(state.copyWith(status: RecurringStatus.failure));
    }
    emit(state.copyWith(status: RecurringStatus.success));
  }

  List<Task> _sortTasks(List<Task> tasks) {
    return tasks
        .where((task) =>
            task.repetition == true)
        .toList();
  }

  List<Event> _sortEvents(List<Event> events) {
    return events
        .where((event) =>
            event.repetition == true)
        .toList();
  }
}