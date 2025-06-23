import 'dart:convert';

import 'package:universal_assistant/data/models/event_model.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/repositories/event_repository.dart';

import '../datasources/locale_db.dart';
import '../models/tag_model.dart';

class EventRepositoryImpl implements EventRepository {
  final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;

  // @override
  // Future<bool> changeReminder(int eventId, int reminderId, Reminder reminder) {
  //   throw UnimplementedError();
  // }

  @override
  Future<bool> deleteEvent(int eventId) async {
    final db = await dbProvider.db;
    final result = await db.delete('Events', where: 'id = ?', whereArgs: [eventId]);
    return result == 0 ? false : true;
  }

  // @override
  // Future<bool> deleteReminder(int eventId, int reminderId) async {
  //   final db = await dbProvider.eventDB;
  //   final result = await db.query('Events', where: 'id = ?', whereArgs: [eventId]);
  //   if(result.isEmpty){
  //     return false;
  //   }else{
  //     EventModel eventModel = EventModel.fromJson(result.first);
  //
  //   }
  // }

  @override
  Future<List<Event>?> getAllEvents() async {
    final db = await dbProvider.db;
    List<Map<String, Object?>> result = await db.query('Events');
    List<Event>? listEvents;
    if (result.isEmpty) {
      return listEvents;
    } else {
      List<Map<String, Object?>> resultTags = await db.query('Tags');
      List<TagModel> modelsTags = List<TagModel>.from(
          resultTags.map((element) => TagModel.fromJson(element)));
      List<EventModel> listModels = List<EventModel>.from(
          result.map((element) => EventModel.fromJson(element, modelsTags)));
      listEvents = listModels.map((element) => element.toEntity()).toList();
      return listEvents;
    }
  }

  @override
  Future<Event?> getEvent(int eventId) async {
    final db = await dbProvider.db;
    final result = await db.query('Events', where: 'id = ?', whereArgs: [eventId]);
    Event? event;
    if (result.isEmpty) {
      return event;
    } else {
      List<Map<String, Object?>> resultTags = await db.query('Tags');
      List<TagModel> modelsTags = List<TagModel>.from(
          resultTags.map((element) => TagModel.fromJson(element)));
      EventModel eventModel = EventModel.fromJson(result.first, modelsTags);
      event = eventModel.toEntity();
      return event;
    }
  }

  @override
  Future<bool> updateEvent(Event event) async {
    final db = await dbProvider.db;
    EventModel eventModel = EventModel.fromEntity(event);
    try {
      await db.update(
        'Events',
        eventModel.toJson(),
        where: 'id = ?',
        whereArgs: [eventModel.id],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> addEvent(Event event) async {
    final db = await dbProvider.db;
    EventModel eventModel = EventModel.fromEntity(event);
    try {
      final result = await db.insert('Events', eventModel.toJson());
      return result == 0 ? false : true;
    } catch (error) {
      return false;
    }
  }
}
