import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_cubit.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_state.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomodoroCubit, PomodoroState>(
      builder: (context, state) {
        //final state = context.select((PomodoroCubit cubit) => cubit.state);
        final percent = state.duration /
            ((state.mode == PomodoroMode.work
                    ? state.pomodoroSettings.durationPomo
                    : (state.mode == PomodoroMode.shortBreak
                        ? state.pomodoroSettings.shortBreak
                        : state.pomodoroSettings.longBreak)) *
                60);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: (){
                  context.read<HomeCubit>().setTab(HomeTab.pomodoroSettings);
                },
                icon: Image.asset('assets/icons/parameters.png',height: 25,),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.inactiveGray,
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 10.0,
                    percent: percent.clamp(0.0, 1.0),
                    //reverse: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.grey.shade300,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(state.duration),
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                            state.mode == PomodoroMode.work
                                ? 'Работа'
                                : 'Перерыв',
                            style: const TextStyle(fontSize: 25)),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            int selected = -1;
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.5,
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  child: Column(
                                    children: [
                                      state.pomodoroTasks.isEmpty
                                          ? const Center(
                                              child: Text(
                                              'Нет подходящих задач',
                                              style: TextStyle(fontSize: 25),
                                            ))
                                          : Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    state.pomodoroTasks.length,
                                                itemBuilder: (context, index) {
                                                  return ElevatedButton(
                                                    onPressed: () {
                                                      selected = index;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Text(state
                                                            .pomodoroTasks[
                                                                index]
                                                            .name),
                                                        Text(state
                                                            .pomodoroTasks[
                                                                index]
                                                            .info),
                                                        Text(state
                                                            .pomodoroTasks[
                                                                index]
                                                            .date
                                                            .toString()),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                              },
                            );
                            if (selected != -1) {
                              context.read<PomodoroCubit>().changeCurrentTask(
                                  state.pomodoroTasks[selected]);
                            }
                          },
                          child: Text(
                            state.currentTask == null
                                ? 'Выбрать задачу'
                                : state.currentTask!.name,
                            style: const TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                IconButton(
                  icon: Icon(
                    state.isRunning ? Icons.pause : Icons.play_arrow,
                    size: 40,
                  ),
                  onPressed: () {
                    if (state.isRunning) {
                      context.read<PomodoroCubit>().pause();
                    } else {
                      context.read<PomodoroCubit>().start();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
