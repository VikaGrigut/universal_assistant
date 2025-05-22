import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_assistant/presentation/widgets/event_item.dart';

import '../../domain/entities/event.dart';

class EventsList extends StatelessWidget {
  EventsList({super.key, required this.events});

  List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => EventItem(event: events[index],),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: events.length);
  }
}
