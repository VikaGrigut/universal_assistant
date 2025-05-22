import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/pages/calendar_page.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/matrix/pages/matrix_page.dart';
import 'package:universal_assistant/presentation/pomodoro/pages/pomodoro_page.dart';
import 'package:universal_assistant/presentation/tags/pages/tags_page.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet_action.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.2,
        title: const Text(
          'Меню',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CupertinoActionSheet(
            actions: [
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab.calendar),//Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage())),
                text: 'Главная',
              ),
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab.tags),
                text: 'Мои теги',
              ),
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab.pomodoro),
                text: 'PomodoroTimer',
              ),
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab.recurring),
                text: 'Повторяющиеся задачи',
              ),
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab.matrix),
                text: 'Матрица Эйзенхауэра',
              ),
            ],
          ),
          CupertinoActionSheet(
            actions: [
              // CalendarSheetAction(
              //   onPressed: () => CalendarPage(),
              //   text: 'Виджеты(календарь)',
              // ),
              CalendarSheetAction(
                onPressed: () => CalendarPage(),
                text: 'Настройки(календарь)',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
