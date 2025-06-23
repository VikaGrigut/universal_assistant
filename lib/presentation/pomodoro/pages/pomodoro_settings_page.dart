import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/do_not_disturb_settings.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_cubit.dart';
import 'package:universal_assistant/presentation/pomodoro/widgets/do_not_disturb_sheet.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet_action.dart';

import '../../../i18n/strings.g.dart';

class PomodoroSettingsPage extends StatefulWidget {
  const PomodoroSettingsPage({super.key});

  @override
  State<PomodoroSettingsPage> createState() => _PomodoroSettingsPageState();
}

class _PomodoroSettingsPageState extends State<PomodoroSettingsPage> {
  final TextEditingController numController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController shortBreakController = TextEditingController();
  final TextEditingController longBreakController = TextEditingController();
  DoNotDisturbSettings? doNotDisturbSettings;

  @override
  Widget build(BuildContext context) {
    final pomodoroSettings =
        context.select((PomodoroCubit cubit) => cubit.state.pomodoroSettings);
    numController.text = pomodoroSettings.numOfPomo.toString();
    durationController.text = pomodoroSettings.durationPomo.toString();
    shortBreakController.text = pomodoroSettings.shortBreak.toString();
    longBreakController.text = pomodoroSettings.longBreak.toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            t.Settings,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    t.NumOfPomo,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: numController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          // hintStyle: const TextStyle(
                          //     //color: Colors.grey,
                          //     ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    t.DurationPomo,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: durationController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          // hintStyle: const TextStyle(
                          //     //color: Colors.grey,
                          //     ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    t.ShortBreak,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: shortBreakController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          // hintStyle: const TextStyle(
                          //     //color: Colors.grey,
                          //     ),
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          // border: InputBorder.none,
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    t.LongBreak,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: longBreakController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          // hintStyle: const TextStyle(
                          //     //color: Colors.grey,
                          //     ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              CupertinoActionSheet(
                actions: [
                  CalendarSheetAction(
                    onPressed: () async {
                      final result =
                          await showModalBottomSheet<DoNotDisturbSettings>(
                        context: context,
                        builder: (context) => DoNotDisturbSheet(),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        backgroundColor: Colors.white,
                      );
                      doNotDisturbSettings = result;
                    },
                    text: t.DoNotDisturb,
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ApplyButton(
                  onPressed: () {
                    final pomoSettings = PomodoroSettings(
                      numOfPomo: int.parse(numController.text),
                      durationPomo: int.parse(durationController.text),
                      shortBreak: int.parse(shortBreakController.text),
                      longBreak: int.parse(longBreakController.text),
                      doNotDisturbSettings: doNotDisturbSettings ?? pomodoroSettings.doNotDisturbSettings,
                    );
                    context.read<PomodoroCubit>().changeSettings(pomoSettings);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
