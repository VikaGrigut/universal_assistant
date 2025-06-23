import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:universal_assistant/core/enums/languages.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/matrix/cubit/matrix_cubit.dart';
import 'package:universal_assistant/presentation/widgets/task_item.dart';

import '../../../domain/entities/task.dart';
import '../../../i18n/strings.g.dart';

class PriorityTasksPage extends StatelessWidget {
  PriorityTasksPage(
      {super.key,
      //required this.tasks,
      required this.priority,
      required this.title,
      required this.color});

  //List<Task> tasks;
  final Priority priority;
  final String title;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    final tasks = context.read<MatrixCubit>().sortTasks(priority);
    final dates = _findDifferentDates(tasks);
    final code = context.read<HomeCubit>().getLanguageString();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(t.Matrix),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              'assets/icons/previous.png',
              height: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Image.asset(
                          'assets/icons/flag2.png',
                          height: 25,
                          color: color,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          title.replaceAll('\n', ''),
                          //maxLines: 1,
                          style: TextStyle(color: color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      final sortedTasks = _sortTasks(tasks ?? [], dates[index]);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5,bottom: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _formatDate(dates[index],code),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children:
                                List<Widget>.generate(sortedTasks.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: TaskItem(task: sortedTasks[index],isMatrix: true,),
                              );
                            }),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> _findDifferentDates(List<Task> tasks) {
    List<DateTime> dates = [];
    for (var task in tasks) {
      DateTime date = DateTime(
        task.date.year,
        task.date.month,
        task.date.day,
      );
      if (dates.isEmpty) {
        dates.add(date);
      } else if (!dates.contains(date)) {
        dates.add(date);
      }
    }
    return dates;
  }

  List<Task> _sortTasks(List<Task> tasks, DateTime date) {
    return tasks
        .where((task) =>
            DateTime(task.date.year, task.date.month, task.date.day) ==
            DateTime(date.year, date.month, date.day))
        .toList();
  }

  String _formatDate(DateTime date, String code) {

    final DateFormat dayFormat = DateFormat('dd', code);
    final DateFormat monthFormat = DateFormat('MMMM', code);
    final DateFormat weekdayFormat = DateFormat.E(code);

    String day = dayFormat.format(date); // 05
    String month = monthFormat.format(date); // марта
    String weekday = weekdayFormat.format(date); // ср


    String capitalizedMonth =
        month[0].toUpperCase() + month.substring(1).toLowerCase();

    return '$day $capitalizedMonth, $weekday';
  }
}
