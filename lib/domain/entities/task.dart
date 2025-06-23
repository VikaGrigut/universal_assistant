import 'package:equatable/equatable.dart';

import 'package:universal_assistant/domain/entities/periodicity.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/entities/tag.dart';

import '../../core/enums/priority.dart';

class Task extends Equatable{
  const Task({
    required this.id,
    required this.name,
    required this.allDay,
    required this.repetition,
    this.periodicity,
    required this.date,
    required this.priority,
    this.tags,
    required this.reminder,
    required this.info,
    required this.isPomodoro,
    required this.isCompleted
});

  final int id;
  final String name;
  final bool allDay;
  final bool repetition;
  final Periodicity? periodicity;
  final DateTime date;
  final Priority priority;
  final List<Tag>? tags;
  final Reminder reminder;
  final String info;
  final bool isPomodoro;
  final bool isCompleted;

  @override
  List<Object?> get props => [
      id,
      name,
      allDay,
      repetition,
      periodicity,
      date,
      priority,
      tags,
      reminder,
      info,
      isPomodoro,
      isCompleted
  ];

}