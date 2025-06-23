import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/recurring/cubit/recurring_cubit.dart';
import 'package:universal_assistant/presentation/widgets/tab_tasks_events.dart';

class RecurringPage extends StatefulWidget {
  const RecurringPage({super.key});

  @override
  State<RecurringPage> createState() => _RecurringPageState();
}

class _RecurringPageState extends State<RecurringPage> {

  @override
  void initState() {
    super.initState();
    context.read<RecurringCubit>().fetchRecurring();
  }

  @override
  Widget build(BuildContext context) {
    final tasks =
        context.select((RecurringCubit cubit) => cubit.state.sortedTasks);
    final events =
        context.select((RecurringCubit cubit) => cubit.state.sortedEvents);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Повторяющиеся задачи и события'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            TabTasksEvents(tasks: tasks, events: events),
          ],
        ),
      ),
    );
  }
}
