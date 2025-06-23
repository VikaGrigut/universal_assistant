import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/task.dart';
import 'package:universal_assistant/domain/repositories/event_repository.dart';
import 'package:universal_assistant/domain/repositories/task_repository.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';

import '../../../../domain/utils/date_time_utils.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final HomeCubit _homeCubit;
  final EventRepository _eventRepository;
  final TaskRepository _taskRepository;
  List<Task>? allTasks;
  List<Event>? allEvents;

  CalendarCubit({
    required HomeCubit homeCubit,
    required EventRepository eventRepository,
    required TaskRepository taskRepository,
  })  : _homeCubit = homeCubit,
        _taskRepository = taskRepository,
        _eventRepository = eventRepository,
        super(CalendarState());

  Future<void> fetchCalendar() async {
    emit(state.copyWith(status: CalendarStatus.loading));

    try {
      allEvents = await _eventRepository.getAllEvents() ?? [];
      allTasks = await _taskRepository.getAllTasks() ?? [];


      emit(state.copyWith(
        status: CalendarStatus.initial,
        events: allEvents == [] ? [] : _sortEvents(allEvents!,date: state.selectedDay),
        tasks: allTasks == [] ? [] : _sortTasks(allTasks!,date: state.selectedDay),
      ));
    } catch (_) {
      emit(state.copyWith(status: CalendarStatus.failure));
    }
    emit(state.copyWith(status: CalendarStatus.success));
  }

  void changeMonth(DateTime month) {
    final isLastDay = DateTimeUtils.isLastDayOfMonth(state.selectedDay);
    final day = isLastDay
        ? DateTimeUtils.lastDayOfMonth(month).day
        : state.selectedDay.day;
    emit(state.copyWith(
      month: month,
      selectedDay: DateTime(state.selectedDay.year, month.month, day),
      events: _sortEvents(allEvents!, month: month),
      tasks: _sortTasks(allTasks!, month: month),
    ));
  }

  void changeWeek(DateTime day) {
    //final newSelectedDay = DateTimeUtils.weekEarlier(day);
    final newMonth = DateTime(day.year, day.month);
    emit(state.copyWith(
      month: newMonth,
      selectedDay: day,
      events: _sortEvents(allEvents!, month: newMonth),
      tasks: _sortTasks(allTasks!, month: newMonth),
    ));
  }

  void currentDate() {
    final now = DateTime.now();
    emit(
        state.copyWith(month: DateTime(now.year, now.month), selectedDay: now));
  }

  void changeSelectedDate(DateTime date) {

    emit(state.copyWith(
        selectedDay: date,
        events: allEvents == null ? null : _sortEvents(allEvents!,date:state.selectedDay),
        tasks: allTasks == null ? null : _sortTasks(allTasks!,date:state.selectedDay)));
  }

  void changeTask(Task changedTask){
    List<Task> newList = [];
    _taskRepository.changeTask(changedTask);
    for (var task in state.tasks) {
      if(task.id == changedTask.id){
        newList.add(changedTask);
        if(task.reminder != changedTask.reminder){
          Reminder.notificationService.deleteNotification(task.reminder.id);
          Reminder.notificationService.scheduledNotification(changedTask.reminder);
        }
      }else{
        newList.add(task);
      }
    }
    emit(state.copyWith(tasks: newList));
  }

  void deleteTask(int taskId){
    List<Task> newList = [];
    _taskRepository.deleteTask(taskId);
    for (var task in state.tasks) {
      if(task.id != taskId){
        newList.add(task);
      }
      else{
        Reminder.notificationService.deleteNotification(task.reminder.id);
      }
    }
    emit(state.copyWith(tasks: newList));
  }

  void changeEvent(Event changedEvent){
    List<Event> newList = [];
    for (var event in state.events) {
      if(event.id == changedEvent.id){
        newList.add(changedEvent);
        if(event.reminders != changedEvent.reminders){
          for(final oldReminder in event.reminders){
            if(!changedEvent.reminders.contains(oldReminder)){
              Reminder.notificationService.deleteNotification(oldReminder.id);
            }
          }
          for(final reminder in changedEvent.reminders){
            if(!event.reminders.contains(reminder)){
              Reminder.notificationService.scheduledNotification(reminder);
            }
          }
        }
      }else{
        newList.add(event);
      }
    }
    _eventRepository.updateEvent(changedEvent);
    emit(state.copyWith(events: newList));
  }

  void deleteEvent(int eventId){
    List<Event> newList = [];
    for (var event in state.events) {
      if(event.id != eventId){
        newList.add(event);
        for(final reminder in event.reminders){
          Reminder.notificationService.deleteNotification(reminder.id);
        }
      }
    }
    _eventRepository.deleteEvent(eventId);
    emit(state.copyWith(events: newList));
  }
  
  int numberOfActivities(DateTime date){
    final events = _sortEvents(allEvents ?? [],date: date);
    final tasks = _sortTasks(allTasks ?? [], date: date);
    return (events.length + tasks.length);
  }

  List<Event> _sortEvents(List<Event> events, {DateTime? month,DateTime? date}) {
    return events
        .where((event) =>
            DateTime(event.dateStart.year, event.dateStart.month, event.dateStart.day) ==
            (month ?? DateTime(date!.year, date.month,
                    date.day)))
        .toList();
  }

  List<Task> _sortTasks(List<Task> tasks, {DateTime? month,DateTime? date}) {
    return tasks
        .where((task) =>
            DateTime(task.date.year, task.date.month, task.date.day) ==
            (month ?? DateTime(date!.year, date.month,
                    date.day)))
        .toList();
  }

}
