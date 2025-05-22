import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/utils/date_utils.dart'
    as utils;
import 'package:universal_assistant/core/enums/measuring_period.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet_action.dart';
import 'package:universal_assistant/presentation/widgets/dialog_basis.dart';
import 'package:universal_assistant/presentation/widgets/duration_repetition_sheet.dart';

class RepeatDialog extends StatefulWidget {
  RepeatDialog({super.key, MeasuringPeriod? selected, bool? isTask})
      : selected = selected ?? MeasuringPeriod.day,
        isTask = isTask ?? false;

  MeasuringPeriod selected;
  List<String> selectedWeekdays = [];
  final bool isTask;

  @override
  State<RepeatDialog> createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<RepeatDialog> {
  DateTime? endOfRepeat;
  String? durationText;
  int? selectedInterval;

  @override
  Widget build(BuildContext context) {
    final weekdaysCount = utils.DateUtils.weekdays.length;
    final activityDate = widget.isTask
        ? context.select((NewTaskCubit cubit) => cubit.state.date)
        : context.select((NewEventCubit cubit) => cubit.state.date);
    final itemWidth = (MediaQuery.of(context).size.width - 25) / weekdaysCount;
    DateTime endOfRepetition = widget.isTask
        ? context.select((NewTaskCubit cubit) => cubit.state.endOfRepetition)
        : context.select((NewEventCubit cubit) => cubit.state.endOfRepetition);
    endOfRepeat = endOfRepetition;
    print('$endOfRepetition} - end');
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Повторять',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                children: MeasuringPeriod.values.map((period) {
                  String text;
                  switch (period) {
                    case MeasuringPeriod.day:
                      text = 'День';
                      break;
                    case MeasuringPeriod.week:
                      text = 'Неделя';
                      break;
                    case MeasuringPeriod.month:
                      text = 'Месяц';
                      break;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[400]!),
                        fixedSize: Size(
                            (MediaQuery.of(context).size.width - 80) / 3, 3),
                        backgroundColor: widget.selected == period
                            ? Colors.grey[400]
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        //fixedSize: Size(buttonSize, 10),
                      ),
                      onPressed: () => setState(() {
                        //notificationText = text;
                        widget.selected = period;
                      }),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: widget.selected == period
                                ? Colors.white
                                : Colors.grey[400]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            CupertinoActionSheet(
              actions: [
                CalendarSheetAction(
                  onPressed: () async {
                    endOfRepeat = await showModalBottomSheet<DateTime>(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) => DurationRepetitionSheet(isTask: widget.isTask,),
                    );
                    setState(() {
                      endOfRepeat ??= endOfRepetition;
                      durationText = DateFormat.yMMMMd().format(endOfRepeat!);
                    });
                  },
                  text: durationText == null ? 'Длительность' : durationText!,
                ),
                widget.selected != MeasuringPeriod.day
                    ? CalendarSheetAction(
                        onPressed: () async {
                          final result = await showDialog<int>(
                            context: context,
                            builder: (context) => IntervalRepetition(
                              selectedMeasuring: widget.selected,
                              selectedIndex: selectedInterval ?? 0,
                            ),
                          );
                          setState(() {
                            selectedInterval = result;
                          });
                        },
                        text: 'Интервал',
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Divider(color: Colors.grey[200]),
            widget.selected == MeasuringPeriod.week
                ? SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 1),
                      itemCount: weekdaysCount,
                      itemBuilder: (context, index) {
                        String text = utils.DateUtils.weekdays[index];
                        return SizedBox(
                          width: itemWidth - 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!widget.selectedWeekdays.contains(text)) {
                                  widget.selectedWeekdays
                                      .add(utils.DateUtils.weekdays[index]);
                                } else {
                                  widget.selectedWeekdays.remove(text);
                                }
                              });
                            },
                            child: Text(
                              utils.DateUtils.weekdays[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: widget.selectedWeekdays.contains(text)
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            widget.selected == MeasuringPeriod.week
                ? Divider(
                    color: Colors.grey[200],
                  )
                : const SizedBox.shrink(),
            ApplyButton(onPressed: () {
              if (endOfRepeat!.isBefore(activityDate)) {
                showDialog(
                  context: context,
                  builder: (context) => DialogBasis(
                    title: ' Внимание!',
                    content: [
                      const Text(
                        'Дата окончания повторения предшествует дате задачи',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 30, 10),
                        ),
                        child: const Text(
                          'Понятно',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (widget.selected == MeasuringPeriod.week &&
                  widget.selectedWeekdays.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => DialogBasis(
                    title: ' Внимание!',
                    content: [
                      const Text(
                        'Выберите дни недели повторения',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width - 30, 10),
                        ),
                        child: const Text(
                          'Понятно',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.pop(context, [
                  widget.selected,
                  endOfRepeat,
                  selectedInterval,
                  widget.selectedWeekdays
                ]);
                widget.isTask ? context.read<NewTaskCubit>().changeRepetition(true) : context.read<NewEventCubit>().changeRepetition(true);
              }
            }),
          ],
        ),
      ),
    );
  }
}

class IntervalRepetition extends StatelessWidget {
  IntervalRepetition(
      {super.key,
      required this.selectedMeasuring,
      required this.selectedIndex});

  MeasuringPeriod selectedMeasuring;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final date = context.select((NewTaskCubit cubit) => cubit.state.date);
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Выберите интервал',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                height: 70,
                child: CupertinoPicker(
                  itemExtent: 32,
                  squeeze: 1.2,
                  scrollController:
                      FixedExtentScrollController(initialItem: selectedIndex),
                  onSelectedItemChanged: (value) => selectedIndex = value,
                  children: selectedMeasuring == MeasuringPeriod.week
                      ? List.generate(
                          5,
                          (index) => Text(
                              'Каждую ${index == 0 ? '' : '${index + 1}-ю'} неделю'))
                      : List.generate(
                          2,
                          (index) => index == 0
                              ? Text('Ежемесячно(${date.day} числа)')
                              : Text(
                                  'Ежемесячно в ${getWeekdayOccurrenceInMonth(date)} ${date.weekday}')),
                ),
              ),
            ),
            ApplyButton(onPressed: () {
              Navigator.pop(context, selectedIndex);
            }),
          ],
        ),
      ),
    );
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
