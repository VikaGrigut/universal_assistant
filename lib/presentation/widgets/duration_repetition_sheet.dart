import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';

import '../../i18n/strings.g.dart';
import '../calendar/cubit/editTask/edit_task_cubit.dart';
import '../calendar/cubit/newTask/new_task_cubit.dart';
import '../calendar/widgets/calendar_basis.dart';
import '../calendar/widgets/calendar_grid.dart';

class DurationRepetitionSheet extends StatelessWidget {
  const DurationRepetitionSheet({super.key, required this.isTask, required this.isNew});

  final bool isTask;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final endOfRepetition = isTask
        ? (isNew
            ? context
                .select((NewTaskCubit cubit) => cubit.state.endOfRepetition)
            : context
                .select((EditTaskCubit cubit) => cubit.state.endOfRepetition))
        : context.select((NewEventCubit cubit) => cubit.state.endOfRepetition);
    final month = DateTime(endOfRepetition.year, endOfRepetition.month);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.DurationUpTo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            CalendarBasis(
              collapsed: Column(
                children: [
                  CalendarGrid(
                      color: Colors.white,
                      isNewTask: true,
                      isRepetition: true,
                      onSwipe: isTask
                          ? (isNew ? (month) => context.read<NewTaskCubit>()
                            ..changeMonthForDuration(month):(month) => context.read<EditTaskCubit>()
                            ..changeMonthForDuration(month))
                          : (month) => context.read<NewEventCubit>()
                            ..changeMonthForDuration(month)
                      ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
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
              onSwipe: isTask
                  ? (isNew ? (month) => context.read<NewTaskCubit>()
                    ..changeMonthForDuration(month)
                    ..fetchNewTask():(month) => context.read<EditTaskCubit>()
                    ..changeMonthForDuration(month)..fetchEditTask()
                    )
                  : (month) => context.read<NewEventCubit>()
                    ..changeMonthForDuration(month)
                    ..fetchNewEvent(),
            ),
            ApplyButton(onPressed: () {
              print(endOfRepetition);
              Navigator.pop(context, endOfRepetition);
            }),
          ],
        ),
      ),
    );
  }
}
