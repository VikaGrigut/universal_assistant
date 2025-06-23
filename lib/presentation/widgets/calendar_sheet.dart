import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/core/enums/measuring_period.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_state.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet_action.dart';
import 'package:universal_assistant/presentation/widgets/notification_dialog.dart';
import 'package:universal_assistant/presentation/widgets/notification_dialog_event.dart';
import 'package:universal_assistant/presentation/widgets/repeat_dialog.dart';
import 'package:universal_assistant/presentation/widgets/time_picker_for_event_sheet.dart';
import 'package:universal_assistant/presentation/widgets/time_picker_for_task_sheet.dart';

import '../../i18n/strings.g.dart';
import '../calendar/cubit/calendar/calendar_cubit.dart';
import '../calendar/cubit/editTask/edit_task_cubit.dart';
import '../calendar/widgets/calendar_basis.dart';
import '../calendar/widgets/calendar_grid.dart';

class CalendarSheet extends StatefulWidget {
  CalendarSheet(
      {super.key, required this.selectedDate, bool? isTask, bool? isNew})
      : isTask = isTask ?? false,
        isNew = isNew ?? false;

  final DateTime selectedDate;
  final bool isTask;
  final isNew;

  @override
  State<CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<CalendarSheet> {
  List<int>? time;

  String? notificationText = t.Reminder;

  Duration? timeDuration;
  List<Duration>? notificationDuration;
  String? repetitionText;

  @override
  Widget build(BuildContext context) {
    //final month = context.select((CalendarCubit cubit) => cubit.state.month);
    final month = widget.isTask
        ? (widget.isNew
            ? context.select((NewTaskCubit cubit) => cubit.state.month)
            : context.select((EditTaskCubit cubit) => cubit.state.month))
        : context.select((NewEventCubit cubit) => cubit.state.month);
    final selected = widget.isTask
        ? (widget.isNew
            ? context.select((NewTaskCubit cubit) => cubit.state.date)
            : context.select((EditTaskCubit cubit) => cubit.state.date))
        : context.select((NewEventCubit cubit) => cubit.state.date);
    final date = widget.isTask
        ? (widget.isNew
            ? context.select((NewTaskCubit cubit) => cubit.state.date)
            : context.select((EditTaskCubit cubit) => cubit.state.date))
        : context.select((NewEventCubit cubit) => cubit.state.event.dateStart);
    final dateEnd = widget.isTask
        ? null
        : context.select((NewEventCubit cubit) => cubit.state.event.dateEnd);
    List<int> time = [date.hour, date.minute];
    if (!widget.isTask) {
      time.addAll([dateEnd!.hour, dateEnd.minute]);
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  t.SelectDate,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 5,
                ),
                CalendarBasis(
                  collapsed: Column(
                    children: [
                      CalendarGrid(

                          ///add
                          color: Colors.white,
                          isNewTask: widget.isTask,
                          isNewEvent: !widget.isTask,
                          onSwipe: widget.isTask
                              ? (widget.isNew
                                  ? (month) => context.read<NewTaskCubit>()
                                    ..changeMonth(month)
                                  : (month) => context.read<EditTaskCubit>()
                                    ..changeMonth(month))
                              : (month) => context.read<NewEventCubit>()
                                ..changeMonth(month)
                          //..fetchNewTask(),
                          ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                DateFormat('MMMM').format(month).toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  month: month,
                  onSwipe: widget.isTask
                      ? (widget.isNew
                          ? (month) => context.read<NewTaskCubit>()
                            ..changeMonth(month)
                            ..fetchNewTask()
                          : (month) => context.read<EditTaskCubit>()
                            ..changeMonth(month)
                            ..fetchEditTask())
                      : (month) => context.read<NewEventCubit>()
                        ..changeMonth(month)
                        ..fetchNewEvent(),
                ),
                CupertinoActionSheet(
                  actions: [
                    CalendarSheetAction(
                      onPressed: () async {
                        // timeDuration = await showModalBottomSheet<Duration>(
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.vertical(
                        //       top: Radius.circular(12),
                        //     ),
                        //   ),
                        //   backgroundColor: Colors.white,
                        //   context: context,
                        //   builder: (BuildContext context) => TimePickerSheet(
                        //     duration:
                        //         timeDuration,
                        //     // hour: time?[0],
                        //     // minute: time?[1],
                        //   ),
                        // );
                        //final date = widget.isTask ? context.select((NewTaskCubit cubit) => cubit.state.task.date) : context.select((NewEventCubit cubit) => cubit.state.event.dateStart);
                        final duration =
                            Duration(hours: time[0], minutes: time[1]);
                        showDialog(
                          context: context,
                          builder: (context) => widget.isTask
                              ? TimePickerForTaskSheet(
                                  duration: duration,
                                  isNew: widget.isNew,
                                )
                              : TimePickerForEventSheet(
                                  durationStart: Duration(
                                      hours: time[0], minutes: time[1]),
                                  durationEnd: Duration(
                                      hours: time[2], minutes: time[3]),
                                ),
                        );

                        // setState(() {
                        //   time = [duration!.inHours,duration!.inMinutes%60];
                        // });
                      },
                      icon: const Icon(Icons.timer),
                      text: widget.isTask
                          ? ((time[0] == 0 && time[1] == 0)
                              ? t.AddTime
                              : '${NumberFormat("00").format(time[0])}:${NumberFormat("00").format(time[1])}')
                          : ((time[0] == 0 &&
                                  time[1] == 0 &&
                                  time[2] == 0 &&
                                  time[3] == 0)
                              ? t.AddTime
                              : '${NumberFormat("00").format(time[0])}:${NumberFormat("00").format(time[1])} - ${NumberFormat("00").format(time[2])}:${NumberFormat("00").format(time[3])}'),
                    ),
                    CalendarSheetAction(
                      onPressed: () async {
                        final result = await showDialog<List<Object>>(
                          context: context,
                          builder: (context) => widget.isTask
                              ? NotificationDialog(
                                  selected: notificationDuration,
                                  isNew: widget.isNew,
                                  ///add
                                )
                              : NotificationDialogEvent(
                                  selectedDurations: notificationDuration,
                                  startTime: DateTime(date.year, date.month,
                                      date.day, time[0], time[1]),
                                ),
                        );
                        setState(() {
                          notificationText = result![0].toString();
                          notificationDuration = result[1] as List<Duration>?;
                        });
                      },
                      icon: Image.asset(
                        'assets/icons/notification4.png',
                        height: 25,
                      ),
                      text: notificationText!,
                    ),
                    CalendarSheetAction(
                      onPressed: () async {
                        final result = await showDialog<List<Object?>>(
                            context: context,
                            builder: (context) => RepeatDialog(isNew: widget.isNew,isTask: widget.isTask,));

                        if (result != null) {
                          switch (result[0]) {
                            case MeasuringPeriod.day:
                              repetitionText = t.Everyday;
                              break;
                            case MeasuringPeriod.week:
                              String days = '';
                              repetitionText =
                                  'Каждую ${result[2] == 0 ? '' : '${(result[2] as int) + 1}-ю'} неделю: ';
                              List<String> weekdays =
                                  (result[3] as List<String>);
                              for (int i = 0; i < weekdays.length; i++) {
                                days =
                                    '$days${weekdays[i]}${i == weekdays.length - 1 ? '' : ','}';
                              }
                              repetitionText = repetitionText! + days;
                              break;
                            case MeasuringPeriod.month:
                              repetitionText =
                                  'Ежемесячно ${result[2] == 0 ? '(${date.day} числа)' : 'в ${getWeekdayOccurrenceInMonth(date)} ${date.weekday}'}';
                              break;
                          }
                          setState(() {});
                        }
                      },
                      icon: Image.asset(
                        'assets/icons/refresh.png',
                        height: 25,
                      ), //SvgPicture.asset('assets/icons/repetition.svg'),
                      text: repetitionText == null ? t.Repeat : repetitionText!,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ApplyButton(
                onPressed: () {
                  int hours = time[0]; //timeDuration!.inHours;
                  int minutes = time[1]; //timeDuration!.inMinutes % 60;
                  widget.isTask
                      ? (widget.isNew
                          ? (context.read<NewTaskCubit>()
                            ..changeDate(DateTime(selected.year, selected.month,
                                selected.day, hours, minutes))
                            ..changeReminder(
                                notificationDuration?[0] ?? const Duration()))
                          : (context.read<EditTaskCubit>()
                            ..changeDate(DateTime(selected.year, selected.month,
                                selected.day, hours, minutes))
                            ..changeReminder(
                                notificationDuration?[0] ?? const Duration())))
                      : (context.read<NewEventCubit>()
                        ..changeDate(selected,
                            startTime: [time[0], time[1]],
                            endTime: [time[2], time[3]])
                        ..changeReminders(
                            notificationDuration ?? [const Duration()]));
                  Navigator.pop(context, selected);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String durationInText(Duration duration) {
    if (duration == const Duration()) {
      return t.AtStartTime;
    } else {
      int days = duration.inDays;
      int hours = duration.inHours % 24;
      int minutes = duration.inMinutes % 60;
      return 'За ${days > 0 ? '$days д' : ''} ${hours > 0 ? '$hours ч' : ''} ${minutes > 0 ? '$minutes мин' : ''}';
    }
  }

  int getWeekdayOccurrenceInMonth(DateTime date) {
    int count = 0;

    for (int day = 1; day <= date.day; day++) {
      final d = DateTime(date.year, date.month, day);
      if (d.weekday == date.weekday) {
        count++;
      }
    }

    return count;
  }
}
