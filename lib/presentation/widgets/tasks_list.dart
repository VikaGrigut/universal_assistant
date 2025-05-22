import 'package:flutter/material.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/presentation/widgets/task_item.dart';

import '../../domain/entities/task.dart';

class TasksList extends StatelessWidget {
  TasksList({super.key,required this.tasks});

  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => TaskItem(task: tasks[index],),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tasks.length);
  }
}
