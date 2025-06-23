import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/core/enums/measuring_period.dart';
import 'package:universal_assistant/domain/entities/periodicity.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/domain/repositories/tag_repository.dart';
//import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_state.dart';

import '../../../../core/enums/priority.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/repositories/task_repository.dart';
import '../../../../domain/utils/date_time_utils.dart';
import '../../../home/cubit/home_cubit.dart';
import 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final HomeCubit _homeCubit;
  final TaskRepository _taskRepository;
  final TagRepository _tagRepository;

  EditTaskCubit({
    required HomeCubit homeCubit,
    required TaskRepository taskRepository,
    required TagRepository tagRepository,
  })  : _homeCubit = homeCubit,
        _taskRepository = taskRepository,
        _tagRepository = tagRepository,
        super(EditTaskState());

  //bool get canSubmit => state.task.name.isNotEmpty && state.task.repetition ;

  Future<void> fetchEditTask({Task? task}) async {
    emit(state.copyWith(status: EditTaskStatus.loading));

    try {
      final tasks = await _taskRepository.getAllTasks();
      emit(state.copyWith(
        status: EditTaskStatus.initial,
        tasks: tasks,
      ));
      // if (tasks != null && tasks.isNotEmpty) {
      //   emit(state.copyWithTask(id: tasks.last.id + 1));
      // }
      if(task != null){
        emit(state.copyWith(task: task,date: task.date));
      }
    } catch (_) {
      emit(state.copyWith(status: EditTaskStatus.failure));
    }
    emit(state.copyWith(status: EditTaskStatus.success));
  }

  Future<List<dynamic>> saveEditTask() async {
    emit(state.copyWith(status: EditTaskStatus.loading));

    try {
      // emit(state.copyWithTask(
      //     id: state.tasks.isEmpty ? 0 : state.tasks.last.id + 1));
      List<Task> tasks = [];
        for (int i = 0; i < state.tasks.length; i++) {
          if(state.tasks[i].id == state.task.id){
            tasks.add(state.task);
          }else{
            tasks.add(state.tasks[i]);
          }
        }
        print(state.tasks);
        Reminder.notificationService.scheduledNotification(state.task.reminder);

        final result = await _taskRepository.updateTask(state.task);


        emit(state.copyWith(tasks: tasks));
        return [result];
    } catch (error) {
      emit(state.copyWith(status: EditTaskStatus.failure));
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
