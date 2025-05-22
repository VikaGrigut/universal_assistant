import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';

class PrioritySheet extends StatefulWidget {
  PrioritySheet({super.key});

  @override
  State<PrioritySheet> createState() => _PrioritySheetState();
}

class _PrioritySheetState extends State<PrioritySheet> {
  final List<bool> checkBoxStatuses = [false, false, false, false];

  //final int checkedIndex;
  final List<String> text = [
    'Важно и срочно',
    'Важно, но не срочно',
    'Не важно, но срочно',
    'Не важно и не срочно'
  ];

  @override
  Widget build(BuildContext context) {
    int checkedIndex =
        context.select((NewTaskCubit cubit) => cubit.state.task.priority.index);
    checkBoxStatuses[checkedIndex] = true;
    return Column(
      children: [
        const Text('Выберите приоритет'),
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
                        context.read<NewTaskCubit>().changePriority(Priority.values[index]);
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
                    Text(text[index],style: TextStyle(fontSize: 20),),
                  ],
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context
                .read<NewTaskCubit>()
                .changePriority(Priority.values[checkedIndex]);
            Navigator.pop(context,Priority.values[checkedIndex]);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[350],
            //fixedSize: Size(buttonSize, 7)
          ),
          child: const Text(
            'Сохранить',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
