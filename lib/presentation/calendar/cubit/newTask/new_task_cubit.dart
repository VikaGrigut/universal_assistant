import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/core/enums/measuring_period.dart';
import 'package:universal_assistant/domain/entities/periodicity.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/domain/repositories/tag_repository.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_state.dart';

import '../../../../core/enums/priority.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/repositories/task_repository.dart';
import '../../../../domain/utils/date_time_utils.dart';
import '../../../home/cubit/home_cubit.dart';

class NewTaskCubit extends Cubit<NewTaskState> {
  final HomeCubit _homeCubit;
  final TaskRepository _taskRepository;
  final TagRepository _tagRepository;

  NewTaskCubit({
    required HomeCubit homeCubit,
    required TaskRepository taskRepository,
    required TagRepository tagRepository,
  })  : _homeCubit = homeCubit,
        _taskRepository = taskRepository,
        _tagRepository = tagRepository,
        super(NewTaskState());


  Future<void> fetchNewTask() async {
    emit(state.copyWith(status: NewTaskStatus.loading));

    try {
      final tasks = await _taskRepository.getAllTasks();
      emit(state.copyWith(
        status: NewTaskStatus.initial,
        tasks: tasks,
      ));
      if (tasks != null && tasks.isNotEmpty) {
        emit(state.copyWithTask(id: tasks.last.id + 1));
      }
    } catch (_) {
      emit(state.copyWith(status: NewTaskStatus.failure));
    }
    emit(state.copyWith(status: NewTaskStatus.success));
  }

  Future<List<dynamic>> saveNewTask() async {
    emit(state.copyWith(status: NewTaskStatus.loading));

    try {
      emit(state.copyWithTask(
          id: state.tasks.isEmpty ? 0 : state.tasks.last.id + 1));
      if (state.canSubmit) {
        List<Task> tasks = [];
        for (int i = 0; i < state.tasks.length; i++) {
          tasks.add(state.tasks[i]);
        }
        tasks.add(state.task);
        // tasks.add(state.task);
        //state.tasks.add(state.task);
        print(state.tasks);
        Reminder.notificationService.scheduledNotification(state.task.reminder);

        final result = await _taskRepository.addTask(state.task);
        if (state.task.repetition == true) {
          Duration period = Duration();
          switch (state.task.periodicity?.measuringPeriod) {
            case null:
            // TODO: Handle this case.
            case MeasuringPeriod.day:
              period = Duration(days: state.task.periodicity!.periodLength);
              break;
            case MeasuringPeriod.week:
              period = Duration(days: state.task.periodicity!.periodLength * 7);
              break;
            case MeasuringPeriod.month:
              period =
                  Duration(days: state.task.periodicity!.periodLength * 30);
              break;
          }

          DateTime nextDate = state.task.date.add(period);
          final dateEnd = state.task.periodicity!.endOfRepetition ??
              state.task.date.add(const Duration(days: 5 * 365));
          while (nextDate.isBefore(dateEnd)) {
            Task newTask = Task(
                id: state.task.id + 1,
                name: state.task.name,
                allDay: state.task.allDay,
                repetition: false,
                date: state.task.date,
                priority: state.task.priority,
                reminder: Reminder(
                    id: state.task.reminder.id + 1,
                    message: state.task.reminder.message,
                    title: state.task.reminder.title,
                    dateOfNotification:
                        state.task.reminder.dateOfNotification.add(period)),
                info: state.task.info,
                isPomodoro: state.task.isPomodoro,
                isCompleted: state.task.isCompleted);
            state.tasks.add(newTask);
            Reminder.notificationService.scheduledNotification(newTask.reminder);

            try {
              await _taskRepository.addTask(newTask);
            } on Exception catch (e) {
              print('error in repetition task');
            }
          }
        }

        emit(state.copyWith(tasks: tasks));
        return [result];
      } else {
        return [
          false,
          'Невозможно сохранить задачу!\nПроверьте заполненные данные.'
        ];
      }
    } catch (error) {
      emit(state.copyWith(status: NewTaskStatus.failure));
      print(error);
      return [false];
    }
  }

  void changeMonth(DateTime month) {
    final isLastDay = DateTimeUtils.isLastDayOfMonth(state.date);
    final day =
        isLastDay ? DateTimeUtils.lastDayOfMonth(month).day : state.date.day;
    emit(state.copyWith(
      month: month,
      date: DateTime(state.date.year, month.month, day),
    ));
  }

  void changeMonthForDuration(DateTime month) {
    final isLastDay = DateTimeUtils.isLastDayOfMonth(state.date);
    final day =
        isLastDay ? DateTimeUtils.lastDayOfMonth(month).day : state.date.day;
    emit(state.copyWith(
      //month: month,
      endOfRepetition: DateTime(state.date.year, month.month, day),
    ));
  }

  void changeDate(DateTime newDate) {
    emit(state.copyWithTask(date: newDate));
    emit(state.copyWith(date: newDate));
  }

  void changeEndOfRepetition(DateTime newDate) {
    //emit(state.copyWithTask(repetition: true));
    emit(state.copyWith(endOfRepetition: newDate)); //endOfRepetition: newDate
    print('${state.date} - ${state.endOfRepetition}');
  }

  void changeTime(int hour, int minute) {
    final date = state.task.date;
    final reminder = state.task.reminder;
    final newDate = DateTime(date.year, date.month, date.day, hour, minute);

    final newReminder = Reminder(
        id: reminder.id,
        message: reminder.message,
        title: reminder.title,
        dateOfNotification: newDate);
    emit(state.copyWithTask(date: newDate));
    emit(state.copyWith(date: newDate));//, reminder: newReminder ????
  }

  void changeName(String newName) {
    emit(state.copyWithTask(name: newName));
  }

  void changePriority(Priority newPriority) {
    emit(state.copyWithTask(priority: newPriority));
  }

  void changeTag(List<Tag> newTags) {
    emit(state.copyWithTask(tags: newTags));
  }

  void changePeriodicity(Periodicity newPeriodicity) {
    emit(state.copyWithTask(periodicity: newPeriodicity));
  }

  void changeAllDay(bool newAllDay) {
    emit(state.copyWithTask(allDay: newAllDay));
  }

  void changeRepetition(bool newRepetition) {
    emit(state.copyWithTask(repetition: newRepetition));
  }

  void changeReminder(Duration duration) {
    DateTime reminderDate = duration == const Duration()
        ? state.task.date
        : state.task.date.subtract(duration);
    print(reminderDate);
    String message = duration == const Duration()
        ? state.task.name
        : '${DateFormat('dd.MM.yyyy HH:mm').format(state.task.date)} запланирована задача: ${state.task.name}';
    Reminder newReminder = Reminder(
        id: state.task.id, //если только одно уведомление
        message: message,
        title: 'Напоминанием',
        dateOfNotification: reminderDate);
    emit(state.copyWithTask(reminder: newReminder));
  }

  void changeReminderMessage() {
    // DateTime reminderDate = duration == const Duration()
    //     ? state.task.date
    //     : state.task.date.subtract(duration);
    // print(reminderDate);
    final reminder = state.task.reminder;
    String message = state.task.date == state.task.reminder.dateOfNotification
        ? state.task.name
        : '${DateFormat('dd.MM.yyyy HH:mm').format(state.task.date)} запланирована задача: ${state.task.name}';
    Reminder newReminder = Reminder(
        id: reminder.id,
        message: message,
        title: reminder.title,
        dateOfNotification: reminder.dateOfNotification);
    emit(state.copyWithTask(reminder: newReminder));
  }

  void changeInfo(String newInfo) {
    emit(state.copyWithTask(info: newInfo));
  }

  void changePomodoro(bool newPomodoro) {
    emit(state.copyWithTask(isPomodoro: newPomodoro));
  }

  void changeCompleted(bool newCompleted) {
    emit(state.copyWithTask(isCompleted: newCompleted));
  }
}
