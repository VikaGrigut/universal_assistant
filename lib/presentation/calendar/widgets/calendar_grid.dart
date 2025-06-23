import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/presentation/calendar/cubit/calendar/calendar_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';

import '../../../domain/utils/date_time_utils.dart';
import '../../utils/date_utils.dart';
import '../cubit/editTask/edit_task_cubit.dart';
import 'calendar_cel.dart';

class CalendarGrid extends StatelessWidget {
  CalendarGrid({
    super.key,
    required this.color,
    bool? isNewTask,
    bool? isRepetition,
    bool? isNewEvent,
    bool? isNew,
    this.onSwipe,
  })  : isTask = isNewTask ?? false,
        isNewEvent = isNewEvent ?? false,
        isNew = isNew ?? false,
        isRepetition = isRepetition ?? false;

  Color color;
  late DateTime month;
  Function? onSwipe;
  final bool isTask;
  final bool isNew;
  final bool isRepetition;
  final bool isNewEvent;

  @override
  Widget build(BuildContext context) {
    final endOfRepetition = isNewEvent
        ? context.select((NewEventCubit cubit) => cubit.state.endOfRepetition)
        : (isNew ? context.select((NewTaskCubit cubit) => cubit.state.endOfRepetition):context.select((EditTaskCubit cubit) => cubit.state.endOfRepetition));
    final isNewActivity = isTask || isNewEvent;
    month = isNewActivity
        ? (isRepetition
            ? DateTime(endOfRepetition.year, endOfRepetition.month)
            : (isTask
                ? (isNew ? context.select((NewTaskCubit cubit) => cubit.state.month):context.select((EditTaskCubit cubit) => cubit.state.month))
                : context.select((NewEventCubit cubit) => cubit.state.month)))
        : context.select((CalendarCubit cubit) => cubit.state.month);
    final selectedDay = isNewActivity
        ? (isRepetition
            ? context
                .select((NewTaskCubit cubit) => cubit.state.endOfRepetition)
            : (isTask
                ? (isNew ? context.select((NewTaskCubit cubit) => cubit.state.date) : context.select((EditTaskCubit cubit) => cubit.state.date))
                : context.select((NewEventCubit cubit) => cubit.state.date)))
        : context.select((CalendarCubit cubit) => cubit.state.selectedDay);
    final now = DateTime.now();

    final cells = GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      primary: false,
      shrinkWrap: true,
      crossAxisCount: DateUtils.weekdays.length,
      childAspectRatio: 1,
      children: _buildCells(context, month, selectedDay, color),
    );

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) =>
          details.velocity.pixelsPerSecond.dx > 0
              ? _previousMonth()
              : _nextMonth(),

      child: cells,
    );
  }

  List<Widget> _buildCells(
      BuildContext context, DateTime month, DateTime selectedDay, Color color) {
    return DateTimeUtils.daysInMonth(month)
        .map((day) => CalendarGridCell(
              day: day,
              month: month,
              selectedDay: selectedDay,
              color: color,
              isNewTask: isTask,
              isNew: isNew,
              isNewEvent: isNewEvent,
              isRepetition: isRepetition,
            ))
        .toList();
  }

  void _previousMonth() {
    final previousMonth = DateTimeUtils.previousMonth(month);
    onSwipe?.call(previousMonth);
  }

  void _nextMonth() {
    final nextMonth = DateTimeUtils.nextMonth(month);
    onSwipe?.call(nextMonth);
  }
}

class CalendarGridCell extends StatelessWidget {
  const CalendarGridCell(
      {super.key,
      required this.day,
      required this.month,
      required this.selectedDay,
      required this.isNewTask,
      required this.isNewEvent,
      required this.isNew,
      required this.isRepetition,
      required this.color});

  final DateTime day;
  final DateTime month;
  final DateTime selectedDay;
  final Color color;
  final bool isNewTask;
  final bool isNew;
  final bool isNewEvent;
  final bool isRepetition;

  bool _isDayAlive(DateTime day, DateTime month) {
    return !DateTimeUtils.isBeforeMonth(day, month) &&
        !DateTimeUtils.isAfterMonth(day, month);
  }

  bool _isSelected() {
    return DateTimeUtils.isSameDay(day, selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = _isSelected();
    final numberOfActivities = context.read<CalendarCubit>().numberOfActivities(day);
    final isAlive = _isDayAlive(day, month);
    final onTapForNewTask = isRepetition
        ? ((date) => context.read<NewTaskCubit>()
          ..changeEndOfRepetition(date)
          ..fetchNewTask())
        : ((date) => context.read<NewTaskCubit>()
          ..changeDate(date)
          ..fetchNewTask());
    final onTapForEditTask = isRepetition
        ? ((date) => context.read<EditTaskCubit>()
          ..changeEndOfRepetition(date)
          ..fetchEditTask())
        : ((date) => context.read<EditTaskCubit>()
          ..changeDate(date)
          ..fetchEditTask());
    final onTapForNewEvent = isRepetition
        ? ((date) => context.read<NewEventCubit>()
          ..changeEndOfRepetition(date)
          ..fetchNewEvent())
        : ((date) => context.read<NewEventCubit>()
          ..changeDate(date)
          ..fetchNewEvent());
    final onTap = isNewTask
        ? (isNew ? onTapForNewTask:onTapForEditTask)
        : (isNewEvent
            ? onTapForNewEvent
            : (date) => context.read<CalendarCubit>()
              ..changeSelectedDate(date)
              ..fetchCalendar());
    return CalendarCell(
      key: ValueKey('weekends_grid_cell_${day}_${isSelected}_$isAlive'),
      date: day,
      color: color,
      selected: isSelected,
      alive: isAlive,
      onTap: onTap,
      numberOfActivities: numberOfActivities,
      children: const [
        SizedBox(height: 9),
      ],
    );
  }
}
