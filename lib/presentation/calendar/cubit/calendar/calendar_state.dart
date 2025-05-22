part of 'calendar_cubit.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    DateTime? month,
    this.tasks = const [],
    this.events = const [],
    DateTime? selectedDay,
  }) : month = month ?? DateTimeUtils.currentMonth(), selectedDay = selectedDay ?? DateTime.now();

  final CalendarStatus status;
  final DateTime month;
  final List<Task> tasks;
  final List<Event> events;
  final DateTime selectedDay;

  // bool get canSubmit =>
  //     status != WeekendsStatus.loading &&
  //     !initialDates.equalIgnorePosition(selectedDates);

  CalendarState copyWith({
    CalendarStatus? status,
    DateTime? month,
    List<Task>? tasks,
    List<Event>? events,
    DateTime? selectedDay,
  }) =>
      CalendarState(
        status: status ?? this.status,
        month: month ?? this.month,
        tasks: tasks ?? this.tasks,
        events: events ?? this.events,
        selectedDay: selectedDay ?? this.selectedDay,
      );

  @override
  List<Object?> get props => [
        status,
        month,
        tasks,
        events,
        selectedDay,
      ];
}
