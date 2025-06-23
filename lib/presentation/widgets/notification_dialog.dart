import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/widgets/new_notification_dialog.dart';

import '../../i18n/strings.g.dart';
import '../calendar/cubit/editTask/edit_task_cubit.dart';

class NotificationDialog extends StatefulWidget {
  NotificationDialog({super.key, required this.isNew,List<Duration>? selected})
      : selected = selected?[0] ?? const Duration();

  Duration selected;
  bool isNew;

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  List<Duration> durations = [
    const Duration(),
    const Duration(hours: 1),
    const Duration(minutes: 30),
    const Duration(minutes: 10)
  ];

  String notificationText = t.AtStartTime;

  @override
  Widget build(BuildContext context) {
    if (!durations.contains(widget.selected)) durations.add(widget.selected);
    final buttonSize = MediaQuery.of(context).size.width - 30;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.Reminder,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: durations.map((duration) {
                  String text;
                  if (duration == const Duration()) {
                    text = t.AtStartTime;
                  } else {
                    int days = duration.inDays;
                    int hours = duration.inHours % 24;
                    int minutes = duration.inMinutes % 60;
                    text =
                        'За ${days > 0 ? '$days д' : ''} ${hours > 0 ? '$hours ч' : ''} ${minutes > 0 ? '$minutes мин' : ''}';
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[400]!),
                        backgroundColor: widget.selected == duration
                            ? Colors.grey[400]
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        //fixedSize: Size(buttonSize, 10),
                      ),
                      onPressed: () => setState(() {
                        notificationText = text;
                        widget.selected = duration;
                      }),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: widget.selected == duration
                                ? Colors.white
                                : Colors.grey[400]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey[400]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fixedSize: Size(buttonSize, 10),
              ),
              onPressed: () async {
                final newDuration = await showDialog(
                    context: context,
                    builder: (context) => NewNotificationDialog(
                          duration: widget.selected,
                        ));
                if (newDuration != null) {
                  setState(() {
                    if (!durations.contains(newDuration)) {
                      durations.add(newDuration);
                    }
                    widget.selected = newDuration;
                  });
                }
              },
              label: Text(
                t.Add,
                style: const TextStyle(color: Colors.black, fontSize: 19),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            ApplyButton(onPressed: () {
              widget.isNew ? context.read<NewTaskCubit>().changeReminder(widget.selected): context.read<EditTaskCubit>().changeReminder(widget.selected);//..fetchNewTask()
              Navigator.pop(context,[notificationText,[widget.selected]]);
            }),
          ],
        ),
      ),
    );
  }
}
