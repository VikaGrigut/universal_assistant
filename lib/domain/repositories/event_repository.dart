import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';

abstract class EventRepository{
  Future<Event?> getEvent(int eventId);

  Future<List<Event>?> getAllEvents();

  Future<bool> addEvent(Event event);

  Future<bool> changeEvent(Event event);

  Future<bool> deleteEvent(int eventId);

//  Future<bool> changeReminder(int eventId, int reminderId, Reminder reminder);

//  Future<bool> deleteReminder(int eventId, int reminderId);
}