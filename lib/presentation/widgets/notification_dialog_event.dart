import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/widgets/new_notification_dialog.dart';

import '../../i18n/strings.g.dart';

class NotificationDialogEvent extends StatefulWidget {
  NotificationDialogEvent(
      {super.key, List<Duration>? selectedDurations, required this.startTime})
      : selectedDurations = selectedDurations ?? [const Duration()];

  List<Duration> selectedDurations;
  DateTime startTime;

  @override
  State<NotificationDialogEvent> createState() =>
      _NotificationDialogEventState();
}

class _NotificationDialogEventState extends State<NotificationDialogEvent> {
  List<Duration> durations = [
    const Duration(),
    const Duration(hours: 1),
    const Duration(minutes: 30),
    const Duration(minutes: 10)
  ];

  List<String> notificationText = [t.AtStartTime];

  @override
  Widget build(BuildContext context) {
    for (final selected in widget.selectedDurations) {
      if (!durations.contains(selected)) durations.add(selected);
    }
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
                        backgroundColor:
                            widget.selectedDurations.contains(duration)
                                ? Colors.grey[400]
                                : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        //fixedSize: Size(buttonSize, 10),
                      ),
                      onPressed: () => (DateTime.now()
                              .isBefore(widget.startTime.subtract(duration)))
                          ? setState(() {
                                  //'$notificationText${notificationText == '' ? '' : ','} $text';
                              if (widget.selectedDurations.contains(duration)) {
                                widget.selectedDurations.remove(duration);
                                notificationText.remove(text);
                              } else {
                                widget.selectedDurations.add(duration);
                                notificationText.add(text);
                              }
                            })
                          : {},
                      child: Text(
                        text,
                        style: TextStyle(
                            color: widget.selectedDurations.contains(duration)
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
                        //duration: widget.selectedDurations,//change
                        ));
                if (newDuration != null) {
                  setState(() {
                    if (!durations.contains(newDuration)) {
                      durations.add(newDuration);
                      widget.selectedDurations.add(newDuration);
                    }
                    //widget.selectedDurations = newDuration;
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
              context
                  .read<NewEventCubit>()
                  .changeReminders(widget.selectedDurations); //..fetchNewTask()
              Navigator.pop(
                  context, [notificationText.toString(), widget.selectedDurations]);
            }),
          ],
        ),
      ),
    );
  }
}
