import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';

abstract class EventRepository{
  Future<Event?> getEvent(int eventId);

  Future<List<Event>?> getAllEvents();

  Future<bool> addEvent(Event event);

  Future<bool> updateEvent(Event event);

  Future<bool> deleteEvent(int eventId);
}