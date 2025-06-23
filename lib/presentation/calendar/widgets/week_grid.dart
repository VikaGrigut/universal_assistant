import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/utils/date_time_utils.dart';
import '../../utils/date_utils.dart';
import '../cubit/calendar/calendar_cubit.dart';
import 'calendar_grid.dart';

class WeekGrid extends StatelessWidget {
  WeekGrid({super.key, this.onSwipe});

  late DateTime selectedDay;
  Function? onSwipe;

  @override
  Widget build(BuildContext context) {
    final month = context.select((CalendarCubit cubit) => cubit.state.month);
    selectedDay =
        context.select((CalendarCubit cubit) => cubit.state.selectedDay);

    final cells = GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      primary: false,
      shrinkWrap: true,
      crossAxisCount: DateUtils.weekdays.length,
      childAspectRatio: 1,
      children: _buildCells(context, month, selectedDay, CupertinoColors.white),
    );
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) =>
          details.velocity.pixelsPerSecond.dx > 0
              ? _previousWeek()
              : _nextWeek(),

      child: cells,
    );
  }

  void _previousWeek(){
    final newSelectedDay = DateTimeUtils.weekEarlier(selectedDay);
    onSwipe?.call(newSelectedDay);
  }

  void _nextWeek(){
    final newSelectedDay = DateTimeUtils.nextWeek(selectedDay);
    onSwipe?.call(newSelectedDay);
  }

  List<Widget> _buildCells(
      BuildContext context, DateTime month, DateTime selectedDay, Color color) {
    return DateTimeUtils.daysInWeek(selectedDay, month)
        .map((day) => CalendarGridCell(
              day: day,
              month: month,
              selectedDay: selectedDay,
              color: color,
              isNewTask: false,
              isNew: false,
              isRepetition: false,
              isNewEvent: false,
            ))
        .toList();
  }
}
