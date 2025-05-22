import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/periodicity.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/tag.dart';

class Event extends Equatable{
  const Event({
    required this.id,
    required this.name,
    required this.allDay,
    required this.repetition,
    this.periodicity,
    required this.dateStart,
    required this.dateEnd,
    this.tag,
    required this.reminders,
    required this.info
});

  final int id;
  final String name;
  final bool allDay;
  final bool repetition;
  final Periodicity? periodicity;
  final DateTime dateStart;
  final DateTime dateEnd;
  final Tag? tag;
  final List<Reminder> reminders;
  final String info;

  @override
  List<Object?> get props => [
      id,
      name,
      allDay,
      repetition,
      periodicity,
      dateStart,
      dateEnd,
      tag,
      reminders,
      info
  ];

}