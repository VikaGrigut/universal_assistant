import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/domain/entities/task.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/calendar/calendar_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/editTask/edit_task_cubit.dart';
import 'package:universal_assistant/presentation/calendar/pages/calendar_page.dart';
import 'package:universal_assistant/presentation/matrix/cubit/matrix_cubit.dart';
import 'package:universal_assistant/presentation/widgets/custom_check_box.dart';

import '../../i18n/strings.g.dart';
import '../tags/cubit/tags_cubit.dart';
import 'new_task_sheet.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.task, bool? isMatrix})
      : isMatrix = isMatrix ?? false;

  Task task;
  final bool isMatrix;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    bool? isCompleted = widget.task.isCompleted;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        children: [
          CustomCheckbox(
            value: isCompleted,
            onChanged: (value) {
              setState(() {
                isCompleted = value;
              });
              Task changedTask = Task(
                  id: widget.task.id,
                  name: widget.task.name,
                  allDay: widget.task.allDay,
                  repetition: widget.task.repetition,
                  date: widget.task.date,
                  priority: widget.task.priority,
                  reminder: widget.task.reminder,
                  info: widget.task.info,
                  isPomodoro: widget.task.isPomodoro,
                  isCompleted: isCompleted!);
              widget.isMatrix
                  ? context.read<MatrixCubit>().changeTask(changedTask)
                  : context.read<CalendarCubit>().changeTask(changedTask);
            },
          ),
          const SizedBox(
            width: 18,
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: isCompleted! ? Colors.white30 : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: const [
                    BoxShadow(
                      color: CupertinoColors.inactiveGray,
                      blurRadius: 6,
                      blurStyle: BlurStyle.outer,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.task.name,
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                isCompleted! ? Colors.grey[700] : Colors.black,
                            decoration: isCompleted!
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            popupMenuTheme: PopupMenuThemeData(
                              color: Colors.grey[100],
                              textStyle: const TextStyle(color: Colors.black),
                            ),
                          ),
                          child: PopupMenuButton(
                            icon: Image.asset(
                              'assets/icons/action_menu.png',
                              height: 25,
                            ),
                            enabled: !isCompleted!,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text(t.Change),
                                  onTap: () {
                                    print('action_menu_edit');
                                    context.read<EditTaskCubit>().fetchEditTask(task:widget.task);
                                    final TextEditingController nameController = TextEditingController();
                                    final TextEditingController infoController = TextEditingController();
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        context.read<TagsCubit>().fetchTags();
                                        return NewTaskSheet(
                                          nameController: nameController,
                                          infoController: infoController,
                                          isNew: false,
                                        );
                                      },
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: Text(t.Delete),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(t.Attention),
                                        content: Text(t.SureDeleteTask),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context.read<CalendarCubit>()
                                                ..deleteTask(widget.task.id)
                                                ..fetchCalendar();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              t.Yes,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              t.No,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    print('action_menu_delete');
                                  },
                                ),
                              ];
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.task.info,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[
                              700]), //isCompleted! ? Colors.grey[700] : Colors.grey[800]
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${NumberFormat("00").format(widget.task.date.hour)}:${NumberFormat("00").format(widget.task.date.minute)}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: isCompleted!
                                        ? Colors.grey[700]
                                        : Colors.black),
                              ),
                              widget.task.repetition
                                  ? Image.asset(
                                      'assets/icons/refresh.png',
                                      height: 15,
                                    )
                                  : const SizedBox.shrink(),
                              Image.asset(
                                'assets/icons/flag2.png',
                                height: 15,
                              ),
                            ],
                          ),
                          widget.task.tags != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Text(
                                    widget.task.tags!
                                        .map((item) => item.name)
                                        .join(', '),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isCompleted!
                                            ? Colors.grey[700]
                                            : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
