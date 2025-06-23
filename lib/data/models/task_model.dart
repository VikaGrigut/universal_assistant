import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:universal_assistant/data/models/periodicity_model.dart';
import 'package:universal_assistant/data/models/reminder_model.dart';
import 'package:universal_assistant/data/models/tag_model.dart';

import 'package:universal_assistant/domain/entities/task.dart';

import '../../core/enums/priority.dart';

class TaskModel extends Equatable{
  const TaskModel({
    required this.id,
    required this.name,
    required this.allDay,
    required this.repetition,
    required this.periodicity,
    required this.date,
    required this.priority,
    required this.tags,
    required this.reminder,
    required this.info,
    required this.isPomodoro,
    required this.isCompleted
});

  final int id;
  final String name;
  final bool allDay;
  final bool repetition;
  final PeriodicityModel? periodicity;
  final DateTime date;
  final Priority priority;
  final List<TagModel>? tags;
  final ReminderModel reminder;
  final String info;
  final bool isPomodoro;
  final bool isCompleted;

  TaskModel.fromJson(Map<String, Object?> json,List<TagModel> tagsList)
      : id = int.parse(json['id'].toString()),
        name = json['name'].toString(),
        allDay = int.parse(json['allDay'].toString()) == 0 ? false : true,
        repetition = int.parse(json['repetition'].toString()) == 0 ? false : true,
        periodicity = json['periodicity'] != '' ? PeriodicityModel.fromJson(jsonDecode(json['periodicity'].toString())) : null,
        date = DateTime.parse(json['date'].toString()),
        priority = Priority.values[int.parse(json['priority'].toString())],
        tags = json['tags'] != "" ? tagsList.where((tag) => List<int>.from(jsonDecode(json['tags'].toString())).contains(tag.id)).toList() : null,
        reminder = ReminderModel.fromJson(jsonDecode(json['reminder'].toString())),
        info = json['info'] != '' ? json['info'].toString() : '',
        isPomodoro = int.parse(json['isPomodoro'].toString()) == 0 ? false : true,
        isCompleted = int.parse(json['isCompleted'].toString()) == 0 ? false : true;

  Task toEntity() => Task(
      id: id,
      name: name,
      allDay: allDay,
      repetition: repetition,
      periodicity: periodicity?.toEntity(),
      date: date,
      priority: priority,
      tags: tags?.map((item) => item.toEntity()).toList(),
      reminder: reminder.toEntity(),
      info: info,
      isPomodoro: isPomodoro,
      isCompleted: isCompleted);

  TaskModel.fromEntity(Task taskEntity)
    :this(id: taskEntity.id,
      name: taskEntity.name,
      allDay: taskEntity.allDay,
      repetition: taskEntity.repetition,
      periodicity: taskEntity.periodicity != null ? PeriodicityModel.fromEntity(taskEntity.periodicity!) : null,
      date: taskEntity.date,
      priority: taskEntity.priority,
      tags: taskEntity.tags?.map((item) => TagModel.fromEntity(item)).toList(),
      reminder: ReminderModel.fromEntity(taskEntity.reminder),
      info: taskEntity.info,
      isPomodoro: taskEntity.isPomodoro,
      isCompleted: taskEntity.isCompleted);

    Map<String, Object?> toJson() => {
        //'id': id,
        'name': name,
        'allDay': allDay == true ? 1 : 0,
        'repetition': repetition == true ? 1 : 0,
        'periodicity': periodicity != null ? jsonEncode(periodicity!.toJson()) : '',
        'date': date.toString(),
        'priority': priority.index,
        'tags': tags  != null ? jsonEncode(List<int>.from(tags!.map((item) => item.id))) : '',
        'reminder': jsonEncode(reminder.toJson()),
        'info': info,
        'isPomodoro': isPomodoro == true ? 1 : 0,
        'isCompleted': isCompleted == true ? 1 : 0
    };

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