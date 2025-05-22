import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/matrix/cubit/matrix_cubit.dart';
import 'package:universal_assistant/presentation/matrix/pages/priority_tasks_page.dart';

import '../../../core/enums/priority.dart';
import '../../../domain/entities/task.dart';
import '../../calendar/cubit/calendar/calendar_cubit.dart';

class MatrixPage extends StatefulWidget {
  MatrixPage({super.key});

  @override
  State<MatrixPage> createState() => _MatrixPageState();
}

class _MatrixPageState extends State<MatrixPage> {
  List<String> matrixTitles = [
    'Важно \nи срочно',
    'Важно, \nно не срочно',
    'Не важно, \nно срочно',
    'Не важно \nи не срочно'
  ];
  List<MaterialColor> colors = [
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    context.read<MatrixCubit>().fetchMatrix();
    final tasks = context.select((MatrixCubit cubit) => cubit.state.tasks);
    bool? checked = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.2,
          centerTitle: true,
          title: const Text(
            'Календарь',
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              //mainAxisExtent: (MediaQuery.of(context).size.height - 100)/2
            ),
            itemCount: matrixTitles.length,
            itemBuilder: (context, index) {
              final List<Task> sortedTasks = context.read<MatrixCubit>().sortTasks(Priority.values[index]);//tasks == null ? [] :
              return GestureDetector(
                onTap: () {
                  if (sortedTasks.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PriorityTasksPage(
                                  //tasks: sortedTasks,
                                  priority: Priority.values[index],
                                  title: matrixTitles[index],
                                  color: colors[index],
                                )));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              matrixTitles[index],
                              style: TextStyle(color: colors[index]),
                            ),
                            Image.asset(
                              'assets/icons/flag2.png',
                              height: 15,
                              color: colors[index],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: sortedTasks.isEmpty
                            ? const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Нет задач',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              )
                            : ListView.builder(
                                itemCount: sortedTasks.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: sortedTasks[index].isCompleted,
                                        onChanged: (value) {
                                          setState(() {
                                            checked = value;
                                          });
                                          Task changedTask = Task(
                                              id: sortedTasks[index].id,
                                              name: sortedTasks[index].name,
                                              allDay: sortedTasks[index].allDay,
                                              repetition:
                                                  sortedTasks[index].repetition,
                                              date: sortedTasks[index].date,
                                              priority:
                                                  sortedTasks[index].priority,
                                              reminder:
                                                  sortedTasks[index].reminder,
                                              info: sortedTasks[index].info,
                                              isPomodoro:
                                                  sortedTasks[index].isPomodoro,
                                              isCompleted: checked!);
                                          context
                                              .read<CalendarCubit>()
                                              .changeTask(changedTask);
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          sortedTasks[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          //minFontSize: 12,
                                          //overflow: TextOverflow.ellipsis,
                                          // style: const TextStyle(
                                          //   fontSize: 12
                                          // ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Task> sortTasks(List<Task> tasks, Priority priority) {
    List<Task> sortedTasks =
        tasks.where((task) => task.priority == priority).toList();
    return sortedTasks;
  }
}
