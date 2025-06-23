import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/menu/widgets/settings_dialog.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet_action.dart';

import '../../../i18n/strings.g.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.2,
        title: Text(
          t.Menu,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CupertinoActionSheet(
            actions: [
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab
                    .calendar),
                text: t.Main,
              ),
              CalendarSheetAction(
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab.tags),
                text: t.Tags,
              ),
              CalendarSheetAction(
                onPressed: () =>
                    context.read<HomeCubit>().setTab(HomeTab.pomodoro),
                text: t.PomodoroTimer,
              ),
              CalendarSheetAction(
                onPressed: () =>
                    context.read<HomeCubit>().setTab(HomeTab.recurring),
                text: t.RecurringTasks,
              ),
              CalendarSheetAction(
                onPressed: () =>
                    context.read<HomeCubit>().setTab(HomeTab.matrix),
                text: t.Matrix,
              ),
            ],
          ),
          CupertinoActionSheet(
            actions: [
              CalendarSheetAction(
                onPressed: () async{
                  await showDialog(
                    context: context,
                    builder: (context) => SettingsDialog(),
                  );
                  setState(() {

                  });
                },
                text: t.Settings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
