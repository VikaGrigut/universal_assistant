import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/task.dart';
import 'package:universal_assistant/presentation/widgets/tasks_list.dart';

import 'events_list.dart';

class TabTasksEvents extends StatelessWidget {
  TabTasksEvents({super.key, required this.tasks, required this.events});

  List<Task> tasks;
  List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(
                            text: 'Задачи',
                          ),
                          Tab(
                            text: 'События',
                          ),
                        ],
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            tasks.isEmpty
                                ? const Center(
                                    child:
                                        Text('Пока нет запланированных задач'),
                                  )
                                : TasksList(
                                    tasks: tasks,
                                  ),
                            events.isEmpty
                                ? const Center(
                                    child: Text(
                                        'Пока нет запланированных событий'),
                                  )
                                : EventsList(events: events),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}
