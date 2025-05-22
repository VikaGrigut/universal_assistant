import 'package:equatable/equatable.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';

import '../../../../domain/entities/event.dart';
import '../../../../domain/entities/periodicity.dart';
import '../../../../domain/entities/tag.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/utils/date_time_utils.dart';

enum NewTaskStatus { initial, loading, success, failure }

class NewTaskState extends Equatable {
  NewTaskState({
    this.status = NewTaskStatus.initial,
    DateTime? date,
    List<Task>? tasks,
    DateTime? month,
    DateTime? endOfRepetition,
    Task? task,
    DateTime? selectedDay,
  })  : date = date ?? DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day,DateTime.now().hour + 1),
        month = month ?? DateTimeUtils.currentMonth(),
        tasks = tasks ?? [],
        endOfRepetition = endOfRepetition ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1),
        task = task ??
            Task(
              id: tasks?.last.id ?? -1,
              name: '',
              allDay: false,
              repetition: false,
              date: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day,DateTime.now().hour + 1),
              priority: Priority.none,
              reminder: Reminder(
                  id: task?.id ?? -1,
                  message: '',
                  title: '',
                  dateOfNotification: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      DateTime.now().hour + 1)),
              info: '',
              isPomodoro: false,
              isCompleted: false,
            ); //selectedDay = selectedDay ?? DateTime.now();

  final NewTaskStatus status;
  final DateTime date; //?
  final List<Task> tasks;
  final Task task;
  final DateTime month;
  final DateTime endOfRepetition;

  bool get canSubmit =>
      task.name != '' && task.date.isAfter(DateTime.now());

  NewTaskState copyWith({
    NewTaskStatus? status,
    DateTime? date,
    List<Task>? tasks,
    Task? task,
    DateTime? month,
    DateTime? endOfRepetition,
    //DateTime? selectedDay,
  }) =>
      NewTaskState(
        status: status ?? this.status,
        date: date ?? this.date,
        tasks: tasks ?? this.tasks,
        task: task ?? this.task,
        month: month ?? this.month,
        endOfRepetition: endOfRepetition ?? this.endOfRepetition,
        //selectedDay: selectedDay ?? this.selectedDay,
      );

  NewTaskState copyWithTask({
    int? id,
    String? name,
    bool? allDay,
    bool? repetition,
    Periodicity? periodicity,
    DateTime? date,
    Priority? priority,
    Tag? tag,
    Reminder? reminder,
    String? info,
    bool? isPomodoro,
    bool? isCompleted,
  }) =>
      copyWith(
          task: Task(
        id: id ?? task.id,
        name: name ?? task.name,
        allDay: allDay ?? task.allDay,
        repetition: repetition ?? task.repetition,
        periodicity: periodicity ?? task.periodicity,
        date: date ?? task.date,
        priority: priority ?? task.priority,
        reminder: reminder ?? task.reminder,
        tag: tag ?? task.tag,
        info: info ?? task.info,
        isPomodoro: isPomodoro ?? task.isPomodoro,
        isCompleted: isCompleted ?? task.isCompleted,
      ));

  @override
  List<Object?> get props => [
        status,
        date,
        tasks,
        month,
        task,
        endOfRepetition,
      ];
}
