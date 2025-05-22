import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';

import '../calendar/cubit/newTask/new_task_cubit.dart';
import '../calendar/widgets/calendar_basis.dart';
import '../calendar/widgets/calendar_grid.dart';

class DurationRepetitionSheet extends StatelessWidget {
  const DurationRepetitionSheet({super.key, required this.isTask});

  final bool isTask;

  @override
  Widget build(BuildContext context) {
    final endOfRepetition = isTask
        ? context.select((NewTaskCubit cubit) => cubit.state.endOfRepetition)
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
            const Text(
              'Длительность до',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            CalendarBasis(
              collapsed: Column(
                children: [
                  CalendarGrid(
                      color: Colors.white,
                      isNewTask: true,
                      isRepetition: true,
                      onSwipe: isTask
                          ? (month) => context.read<NewTaskCubit>()
                            ..changeMonthForDuration(month)
                          : (month) => context.read<NewEventCubit>()
                            ..changeMonthForDuration(month)
                      //..fetchNewTask(),
                      ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
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
                  ? (month) => context.read<NewTaskCubit>()
                    ..changeMonthForDuration(month)
                    ..fetchNewTask()
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
