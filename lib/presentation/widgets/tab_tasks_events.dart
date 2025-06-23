import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/task.dart';
import 'package:universal_assistant/presentation/widgets/tasks_list.dart';
import 'package:universal_assistant/i18n/strings.g.dart';

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
                      TabBar(
                        tabs: [
                          Tab(
                            text: t.Tasks,
                          ),
                          Tab(
                            text: t.Events,
                          ),
                        ],
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            tasks.isEmpty
                                ? Center(
                                    child:
                                        Text(t.NoTasks),
                                  )
                                : TasksList(
                                    tasks: tasks,
                                  ),
                            events.isEmpty
                                ? Center(
                                    child: Text(
                                        t.NoEvents),
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
