import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:universal_assistant/data/models/periodicity_model.dart';
import 'package:universal_assistant/data/models/reminder_model.dart';
import 'package:universal_assistant/data/models/tag_model.dart';
import 'package:universal_assistant/domain/entities/event.dart';

class EventModel extends Equatable{
  const EventModel({
    required this.id,
    required this.name,
    required this.allDay,
    required this.repetition,
    required this.periodicity,
    required this.dateStart,
    required this.dateEnd,
    required this.tag,
    required this.reminders,
    required this.info
});

  final int id;
  final String name;
  final bool allDay;
  final bool repetition;
  final PeriodicityModel? periodicity;
  final DateTime dateStart;
  final DateTime dateEnd;
  final TagModel? tag;
  final List<ReminderModel> reminders;
  final String info;

  EventModel.fromJson(Map<String, Object?> json)
    :id = int.parse(json['id'].toString()),
      name = json['name'].toString(),
      allDay = int.parse(json['allDay'].toString()) == 0 ? false : true,
      repetition = int.parse(json['repetition'].toString()) == 0 ? false : true,
      periodicity = json['periodicity'] != '' ? PeriodicityModel.fromJson(jsonDecode(json['periodicity'].toString())) : null,
      dateStart = DateTime.parse(json['dateStart'].toString()),
      dateEnd = DateTime.parse(json['dateEnd'].toString()),
      tag = json['tag'] != '' ? TagModel.fromJson(jsonDecode(json['tag'].toString())) : null,
      reminders = List<ReminderModel>.from(jsonDecode(json['reminders'].toString()).map((item) => ReminderModel.fromJson(jsonDecode(item)))),
      info = json['info'] != '' ? json['info'].toString() : '';

  Event toEntity() => Event(
      id: id,
      name: name,
      allDay: allDay,
      repetition: repetition,
      periodicity: periodicity?.toEntity(),
      dateStart: dateStart,
      dateEnd: dateEnd,
      tag: tag?.toEntity(),
      reminders: reminders.map((item) => item.toEntity()).toList(),
      info: info
  );

    EventModel.fromEntity(Event eventEntity)
    :this(id: eventEntity.id,
      name: eventEntity.name,
      allDay: eventEntity.allDay,
      repetition: eventEntity.repetition,
      periodicity: eventEntity.periodicity != null ? PeriodicityModel.fromEntity(eventEntity.periodicity!) : null,
      dateStart: eventEntity.dateStart,
      dateEnd: eventEntity.dateEnd,
      tag: eventEntity.tag != null ? TagModel.fromEntity(eventEntity.tag!) : null,
      reminders: eventEntity.reminders.map((item) => ReminderModel.fromEntity(item)).toList(),
      info: eventEntity.info
    );

    Map<String, Object?> toJson() => {
        //'id': id,
        'name': name,
        'allDay': allDay == true ? 1 : 0,
        'repetition': repetition == true ? 1 : 0,
        'periodicity': periodicity != null ? jsonEncode(periodicity!.toJson()) : '',
        'dateStart': dateStart.toString(),
        'dateEnd': dateEnd.toString(),
        'tag': tag  != null ? jsonEncode(tag!.toJson()) : '',
        'reminders': jsonEncode(List<String>.from(reminders.map((item) => jsonEncode(item.toJson())))),
        'info': info ?? ''
    };

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