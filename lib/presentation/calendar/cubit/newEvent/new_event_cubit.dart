import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/domain/entities/periodicity.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/domain/repositories/tag_repository.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_state.dart';

import '../../../../core/enums/priority.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/repositories/event_repository.dart';
import '../../../../domain/repositories/task_repository.dart';
import '../../../../domain/utils/date_time_utils.dart';
import '../../../home/cubit/home_cubit.dart';
import 'new_event_state.dart';

class NewEventCubit extends Cubit<NewEventState> {
  final HomeCubit _homeCubit;
  final EventRepository _eventRepository;
  final TagRepository _tagRepository;

  NewEventCubit({
    required HomeCubit homeCubit,
    required EventRepository eventRepository,
    required TagRepository tagRepository,
  })  : _homeCubit = homeCubit,
        _eventRepository = eventRepository,
        _tagRepository = tagRepository,
        super(NewEventState());

  //bool get canSubmit => state.task.name.isNotEmpty && state.task.repetition ;

  Future<void> fetchNewEvent() async {
    emit(state.copyWith(status: NewEventStatus.loading));

    try {
      final events = await _eventRepository.getAllEvents();
      emit(state.copyWith(
        status: NewEventStatus.initial,
        events: events,
      ));
    } catch (_) {
      emit(state.copyWith(status: NewEventStatus.failure));
    }
    emit(state.copyWith(status: NewEventStatus.success));
  }

  Future<List<dynamic>> saveNewEvent() async {
    emit(state.copyWith(status: NewEventStatus.loading));

    try {
      emit(state.copyWithEvent(
          id: state.events.isEmpty ? 0 : state.events.last.id + 1));
      List<Event> events = [];
      for (int i = 0; i < state.events.length; i++) {
        events.add(state.events[i]);
      }
      events.add(state.event);
      // tasks.add(state.task);
      //state.tasks.add(state.task);
      emit(state.copyWith(events: events));
      print(state.events);
      final result = await _eventRepository.addEvent(state.event);
      for (final reminder in state.event.reminders) {
        Reminder.notificationService.scheduledNotification(reminder);
      }
      return [result, ''];
    } catch (error) {
      emit(state.copyWith(status: NewEventStatus.failure));
      print(error);
      return [false, error];
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

  void changeDate(DateTime date,{List<int>? startTime, List<int>? endTime}) {
    final newStartDate = DateTime(date.year,date.month,date.day,startTime?[0] ?? state.event.dateStart.hour,startTime?[1] ?? state.event.dateStart.minute);
    final newEndDate = DateTime(date.year,date.month,date.day,endTime?[0] ?? state.event.dateEnd.hour,endTime?[0] ?? state.event.dateEnd.minute);
    emit(state.copyWithEvent(
      dateStart: newStartDate,
      dateEnd: newEndDate,
    ));
    emit(state.copyWith(date: date));
  }

  void changeEndOfRepetition(DateTime newDate) {
    //emit(state.copyWithTask(repetition: true));
    emit(state.copyWith(endOfRepetition: newDate)); //endOfRepetition: newDate
    print('${state.date} - ${state.endOfRepetition}');
  }

  void changeTime(List<int> startTime, List<int> endTime) {
    final date = state.event.dateStart;
    final reminder = state.event.reminders[0];
    final newStartDate =
        DateTime(date.year, date.month, date.day, startTime[0], startTime[1]);
    final newEndDate =
        DateTime(date.year, date.month, date.day, endTime[0], endTime[1]);
    // for(final reminder in state.event.reminders){
    //   if(reminder.id == )
    // }
    //
    // final newReminder = Reminder(
    //     id: reminder.id,
    //     message: reminder.message,
    //     title: reminder.title,
    //     dateOfNotification: newStartDate);
    emit(state.copyWithEvent(
        dateStart: newStartDate,
        dateEnd: newEndDate)); //, reminder: newReminder ????
  }

  void changeName(String newName) {
    emit(state.copyWithEvent(name: newName));
  }

  void changePriority(Priority newPriority) {
    emit(state.copyWithEvent(priority: newPriority));
  }

  void changeTag(List<Tag> newTags) {
    emit(state.copyWithEvent(tags: newTags));
  }

  void changePeriodicity(Periodicity newPeriodicity) {
    emit(state.copyWithEvent(periodicity: newPeriodicity));
  }

  void changeAllDay(bool newAllDay) {
    emit(state.copyWithEvent(allDay: newAllDay));
  }

  void changeRepetition(bool newRepetition) {
    emit(state.copyWithEvent(repetition: newRepetition));
  }

  void changeReminders(List<Duration> durations) { //проверить через дебагер
    List<Reminder> newReminders = [];
    for(final duration in durations){
      DateTime reminderDate = duration == const Duration()
          ? state.event.dateStart
          : state.event.dateStart.subtract(duration);
      print(reminderDate);
      String message = duration == const Duration()
          ? state.event.name
          : '${DateFormat('dd.MM.yyyy HH:mm').format(state.event.dateStart)} запланировано событие: ${state.event.name}';
      Reminder newReminder = Reminder(
          id: int.parse('${state.event.id}${durations.indexOf(duration)}'),
          message: message,
          title: 'Напоминанием',
          dateOfNotification: reminderDate);
      if(!state.event.reminders.contains(newReminder)){
        newReminders.add(newReminder);
      }
    }
    for(final oldReminder in state.event.reminders){
      if(!newReminders.contains(oldReminder)){
        Reminder.notificationService.deleteNotification(oldReminder.id);
      }
    }
    for(final reminder in newReminders){
      if(!state.event.reminders.contains(reminder)){
        Reminder.notificationService.scheduledNotification(reminder);
      }
    }
    emit(state.copyWithEvent(reminders: newReminders));
  }

  void changeRemindersMessage(){
    List<Reminder> newReminders = [];
    for(final oldReminder in state.event.reminders){
      String message = state.event.dateStart == oldReminder.dateOfNotification
          ? state.event.name
          : '${DateFormat('dd.MM.yyyy HH:mm').format(state.event.dateStart)} запланировано событие: ${state.event.name}';
      Reminder newReminder = Reminder(
        id: oldReminder.id,
        message: message,
        title: oldReminder.title,
        dateOfNotification: oldReminder.dateOfNotification);
      newReminders.add(newReminder);
    }
    emit(state.copyWithEvent(reminders: newReminders));
  }

  void changeInfo(String newInfo) {
    emit(state.copyWithEvent(info: newInfo));
  }

  void changePomodoro(bool newPomodoro) {
    emit(state.copyWithEvent(isPomodoro: newPomodoro));
  }

  void changeCompleted(bool newCompleted) {
    emit(state.copyWithEvent(isCompleted: newCompleted));
  }
}
