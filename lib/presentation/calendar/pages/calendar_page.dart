import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/domain/entities/reminder.dart';
import 'package:universal_assistant/domain/repositories/event_repository.dart';
import 'package:universal_assistant/injection.dart';
import 'package:universal_assistant/presentation/calendar/cubit/calendar/calendar_cubit.dart';
import 'package:universal_assistant/presentation/calendar/widgets/calendar_basis.dart';
import 'package:universal_assistant/presentation/calendar/widgets/calendar_grid.dart';
import 'package:universal_assistant/presentation/calendar/widgets/week_grid.dart';
import 'package:universal_assistant/presentation/calendar/widgets/weekdays.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';
import 'package:universal_assistant/presentation/widgets/events_list.dart';
import 'package:universal_assistant/presentation/widgets/new_event_sheet.dart';
import 'package:universal_assistant/presentation/widgets/tab_tasks_events.dart';
import 'package:universal_assistant/presentation/widgets/new_task_sheet.dart';
import 'package:universal_assistant/presentation/widgets/tasks_list.dart';

import '../cubit/newTask/new_task_cubit.dart';
import '../widgets/expandable_panel.dart';
import 'package:universal_assistant/i18n/strings.g.dart';

// class CalendarPage extends StatefulWidget {
//   const CalendarPage({super.key});
//
//   @override
//   State<CalendarPage> createState() => _CalendarPageState();
// }

class CalendarPage extends StatefulWidget {
  // static Route<void> route() {
  //   return MaterialPageRoute(
  //     builder: (_) => BlocProvider<CalendarCubit>(
  //       create: (_) => CalendarCubit(
  //           homeCubit: locator(),
  //           eventRepository: locator(),
  //           taskRepository: locator())
  //         ..fetchCalendar(),
  //       child: CalendarPage(),
  //     ),
  //   );
  // }

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  void initState() {
    super.initState();
    locator.get<CalendarCubit>().fetchCalendar();
  }
  @override
  Widget build(BuildContext context) {
    final month = context.select((CalendarCubit cubit) => cubit.state.month);
    return BlocListener<CalendarCubit, CalendarState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == CalendarStatus.failure) {
          print(
              'Что-то пошло не так при отправке запроса.\nПопробуйте, пожалуйста, позже.');
        } else if (state.status == CalendarStatus.success) {
          print('Успех');
        }
      },
      child: CalendarView(month: month),
    );
  }
}

class CalendarView extends StatelessWidget {
  CalendarView({super.key, required this.month});

  DateTime month;

  @override
  Widget build(BuildContext context) {
    //context.read<CalendarCubit>().fetchCalendar();
    final events = context.select((CalendarCubit cubit) => cubit.state.events);
    final tasks = context.select((CalendarCubit cubit) => cubit.state.tasks);
    final locale = context.read<HomeCubit>().getLanguageString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.2,
          centerTitle: true,
          title: Text(
            t.Calendar,
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            ExpandablePanel.expandCollapse(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatMonth(month,locale),
                    style: const TextStyle(fontSize: 19),
                  ),
                ],
              ),
              expanded: CalendarBasis(
                expanded: Column(
                  children: [
                    CalendarGrid(
                        color: Colors.white,
                        onSwipe: (month) =>
                            context.read<CalendarCubit>()..changeMonth(month)
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                month: month,
                onSwipe: (month) => context.read<CalendarCubit>()
                  ..changeMonth(month)
                  ..fetchCalendar(),
              ),
              collapsed: CalendarBasis(
                collapsed: Column(
                  children: [
                    WeekGrid(
                      onSwipe: (day) => context.read<CalendarCubit>()
                        ..changeWeek(day)
                        ..fetchCalendar(),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                month: month,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TabTasksEvents(tasks: tasks, events: events),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.black,
        //   onPressed: () {
        //     // Reminder.notificationService.scheduledNotification(Reminder(
        //     //     id: 0,
        //     //     message: 'message',
        //     //     title: 'title',
        //     //     dateOfNotification: DateTime.now()));
        //     showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               ElevatedButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                   showModalBottomSheet(
        //                     shape: const RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.vertical(
        //                         top: Radius.circular(12),
        //                       ),
        //                     ),
        //                     context: context,
        //                     builder: (context) {
        //                       context.read<TagsCubit>().fetchTags();
        //                       return NewTaskSheet(
        //                         nameController: nameController,
        //                         infoController: infoController,
        //                       );
        //                     },
        //                   );
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                     backgroundColor: Colors.grey),
        //                 child: const Text(
        //                   'task',
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //               ),
        //               ElevatedButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                   showModalBottomSheet(
        //                     shape: const RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.vertical(
        //                         top: Radius.circular(12),
        //                       ),
        //                     ),
        //                     context: context,
        //                     builder: (context) => NewEventSheet(
        //                       nameController: nameController,
        //                       infoController: infoController,
        //                     ),
        //                   );
        //                 },
        //                 style: ElevatedButton.styleFrom(
        //                     backgroundColor: Colors.grey),
        //                 child: const Text(
        //                   'event',
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //               )
        //             ],
        //           );
        //         });
        //   },
        //   child: const Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }

  String _formatMonth(DateTime date, String code){
    final DateFormat yearFormat = DateFormat('y', code);
    final DateFormat monthFormat = DateFormat('MMMM', code);

    String month = monthFormat.format(date);
    String year = yearFormat.format(date);

    String capitalizedMonth =
        month[0].toUpperCase() + month.substring(1).toLowerCase();
    return '$capitalizedMonth $year';
  }
}
