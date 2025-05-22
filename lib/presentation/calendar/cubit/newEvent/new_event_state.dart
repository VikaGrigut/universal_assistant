import 'package:equatable/equatable.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';

import '../../../../domain/entities/event.dart';
import '../../../../domain/entities/periodicity.dart';
import '../../../../domain/entities/tag.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/utils/date_time_utils.dart';

enum NewEventStatus { initial, loading, success, failure }

class NewEventState extends Equatable {
  NewEventState({
    this.status = NewEventStatus.initial,
    DateTime? date,
    this.events = const [],
    DateTime? month,
    DateTime? endOfRepetition,
    Event? event,
    DateTime? selectedDay,
  })  : date = date ?? DateTime.now(),
        month = month ?? DateTimeUtils.currentMonth(),
        endOfRepetition = endOfRepetition ??
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day + 1),
        event = event ??
            Event(
              id: -1,
              name: '',
              allDay: false,
              repetition: false,
              dateStart: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  ((0 < DateTime.now().minute && 30 > DateTime.now().minute)
                      ? DateTime.now().hour
                      : DateTime.now().hour + 1),
                  ((0 < DateTime.now().minute && 30 > DateTime.now().minute)
                      ? 30
                      : 0)),
              dateEnd: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  ((0 < DateTime.now().minute && 30 > DateTime.now().minute)
                      ? DateTime.now().hour + 1
                      : DateTime.now().hour + 2),
                  ((0 < DateTime.now().minute && 30 > DateTime.now().minute)
                      ? 30
                      : 0)),
              reminders: [
                Reminder(
                    id: -1,
                    message: '',
                    title: '',
                    dateOfNotification: DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        ((0 < DateTime.now().minute &&
                                30 > DateTime.now().minute)
                            ? DateTime.now().hour
                            : DateTime.now().hour + 1),
                        ((0 < DateTime.now().minute &&
                                30 > DateTime.now().minute)
                            ? 30
                            : 0)))
              ],
              info: '',
            ); //selectedDay = selectedDay ?? DateTime.now();

  final NewEventStatus status;
  final DateTime date; //?
  final List<Event> events;
  final Event event;
  final DateTime month;
  final DateTime endOfRepetition;

  // bool get canSubmit =>
  //     status != WeekendsStatus.loading &&
  //     !initialDates.equalIgnorePosition(selectedDates);

  NewEventState copyWith({
    NewEventStatus? status,
    DateTime? date,
    List<Event>? events,
    Event? event,
    DateTime? month,
    DateTime? endOfRepetition,
    //DateTime? selectedDay,
  }) =>
      NewEventState(
        status: status ?? this.status,
        date: date ?? this.date,
        events: events ?? this.events,
        event: event ?? this.event,
        month: month ?? this.month,
        endOfRepetition: endOfRepetition ?? this.endOfRepetition,
        //selectedDay: selectedDay ?? this.selectedDay,
      );

  NewEventState copyWithEvent({
    int? id,
    String? name,
    bool? allDay,
    bool? repetition,
    Periodicity? periodicity,
    DateTime? dateStart,
    DateTime? dateEnd,
    Priority? priority,
    Tag? tag,
    List<Reminder>? reminders,
    String? info,
    bool? isPomodoro,
    bool? isCompleted,
  }) =>
      copyWith(
          event: Event(
        id: id ?? event.id,
        name: name ?? event.name,
        allDay: allDay ?? event.allDay,
        repetition: repetition ?? event.repetition,
        periodicity: periodicity ?? event.periodicity,
        dateStart: dateStart ?? event.dateStart,
        dateEnd: dateEnd ?? event.dateEnd,
        tag: tag ?? event.tag,
        reminders: reminders ?? event.reminders,
        info: info ?? event.info,
      ));

  @override
  List<Object?> get props => [
        status,
        date,
        events,
        month,
        event,
        endOfRepetition,
      ];
}
