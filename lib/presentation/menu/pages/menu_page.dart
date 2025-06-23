import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/core/enums/languages.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/pages/calendar_page.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/matrix/pages/matrix_page.dart';
import 'package:universal_assistant/presentation/pomodoro/pages/pomodoro_page.dart';
import 'package:universal_assistant/presentation/tags/pages/tags_page.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet_action.dart';
import 'package:universal_assistant/presentation/widgets/custom_check_box.dart';

import '../../../i18n/strings.g.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final lang = context.select((HomeCubit cubit) => cubit.state.language);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.2,
        title: Text(
          t.Menu,
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
                onPressed: () => context.read<HomeCubit>().setTab(HomeTab
                    .calendar), //Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage())),
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        t.Settings,
                        style: const TextStyle(fontSize: 20),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.SelectLanguage,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: List.generate(
                                Languages.values.length,
                                (int index) {
                                  return Row(
                                    children: [
                                      CustomCheckbox(
                                        value: Languages.values[index] == lang
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          if (value == true) {
                                            context
                                                .read<HomeCubit>()
                                                .changeLanguage(
                                                    Languages.values[index]);
                                          }
                                          setState(() {});
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        Languages.values[index].name,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
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
