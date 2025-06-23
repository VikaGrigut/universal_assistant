import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';

import '../../i18n/strings.g.dart';
import '../calendar/cubit/editTask/edit_task_cubit.dart';

class PrioritySheet extends StatefulWidget {
  PrioritySheet({super.key, required this.isNew});

  bool isNew;

  @override
  State<PrioritySheet> createState() => _PrioritySheetState();
}

class _PrioritySheetState extends State<PrioritySheet> {
  final List<bool> checkBoxStatuses = [false, false, false, false];

  //final int checkedIndex;
  final List<String> text = [
    t.ImportantAndUrgent,
    t.ImportantAndNotUrgent,
    t.NotImportantAndUrgent,
    t.NotImportantAndNotUrgent
  ];

  @override
  Widget build(BuildContext context) {
    int checkedIndex = widget.isNew ? context.select((NewTaskCubit cubit) => cubit.state.task.priority.index) : context.select((EditTaskCubit cubit) => cubit.state.task.priority.index);
    checkBoxStatuses[checkedIndex] = true;
    return Column(
      children: [
        Text(t.SelectPriority),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor:
                          WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.black;
                        }
                        return null;
                      }),
                      shape: const CircleBorder(),
                      value: checkBoxStatuses[index],
                      onChanged: (value) {
                        widget.isNew ? context.read<NewTaskCubit>().changePriority(Priority.values[index]): context.read<EditTaskCubit>().changePriority(Priority.values[index]);
                          checkBoxStatuses[checkedIndex] = false;
                          checkBoxStatuses[index] = value!;
                          checkedIndex = index;
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      'assets/icons/flag.png',
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(text[index],style: const TextStyle(fontSize: 20),),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.isNew ? (context
                .read<NewTaskCubit>()
                .changePriority(Priority.values[checkedIndex])):(context
                .read<EditTaskCubit>()
                .changePriority(Priority.values[checkedIndex]));
            Navigator.pop(context,Priority.values[checkedIndex]);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[350],
            //fixedSize: Size(buttonSize, 7)
          ),
          child: Text(
            t.Save,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
