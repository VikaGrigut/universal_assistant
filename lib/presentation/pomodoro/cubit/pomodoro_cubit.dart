import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/do_not_disturb_settings.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_state.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/repositories/task_repository.dart';
import '../../../domain/repositories/settings_repository.dart';

class PomodoroCubit extends Cubit<PomodoroState> {
  final TaskRepository _taskRepository;
  final SettingsRepository _settingsRepository;
  Timer? _timer;

  PomodoroCubit({
    required TaskRepository taskRepository,
    required SettingsRepository settingRepository,
  })  : _taskRepository = taskRepository,
        _settingsRepository = settingRepository,
        super(PomodoroState());

  Future<void> fetchPomodoro() async {
    emit(state.copyWith(status: PomodoroStatus.loading));

    try {
      final allTasks = await _taskRepository.getAllTasks();
      final settings = await _settingsRepository.getSettings();

      emit(state.copyWith(
        status: PomodoroStatus.initial,
        pomodoroTasks: allTasks == null ? [] : _sortTasks(allTasks),
        pomodoroSettings: settings![1].pomodoroSettings,
      ));
    } catch (_) {
      emit(state.copyWith(status: PomodoroStatus.failure));
    }
    emit(state.copyWith(status: PomodoroStatus.success));
  }

  Future<void> changeSettings(PomodoroSettings pomoSettings) async {
    final result = await _settingsRepository.savePomodoroSettings(pomoSettings);
    emit(state.copyWith(pomodoroSettings: pomoSettings));
  }

  Future<void> changeDoNotDisturbSettings(DoNotDisturbSettings settings) async {
    //final result = await _settingsRepository.savePomodoroSettings(settings);
    PomodoroSettings newPomoSettings = PomodoroSettings(
      numOfPomo: state.pomodoroSettings.numOfPomo,
      durationPomo: state.pomodoroSettings.durationPomo,
      shortBreak: state.pomodoroSettings.shortBreak,
      longBreak: state.pomodoroSettings.longBreak,
      doNotDisturbSettings: settings,
    );
    emit(state.copyWith(pomodoroSettings: newPomoSettings));
  }

  void start() {
    if (state.isRunning) return;

    emit(state.copyWith(isRunning: true));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newDuration = state.duration - 1;

      if (newDuration <= 0) {
        _timer?.cancel();
        _onSessionComplete();
      } else {
        emit(state.copyWith(duration: newDuration));
      }
    });
  }

  void _onSessionComplete() {
    PomodoroMode nextMode;
    int nextDuration;
    int completed = state.completedCycles;

    switch (state.mode) {
      case PomodoroMode.work:
        completed += 1;
        if (completed % state.pomodoroSettings.numOfPomo == 0) {
          nextMode = PomodoroMode.longBreak;
          nextDuration = state.pomodoroSettings.longBreak * 60;
        } else {
          nextMode = PomodoroMode.shortBreak;
          nextDuration = state.pomodoroSettings.shortBreak * 60;
        }
        break;
      case PomodoroMode.shortBreak:
      case PomodoroMode.longBreak:
        nextMode = PomodoroMode.work;
        nextDuration = state.pomodoroSettings.durationPomo * 60;
        break;
    }

    emit(state.copyWith(
      duration: nextDuration,
      isRunning: false,
      completedCycles: completed,
      mode: nextMode,
    ));
  }

  void changeCurrentTask(Task task) {
    emit(state.copyWith(currentTask: task));
  }

  void pause() {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void reset() {
    _timer?.cancel();
    //emit(PomodoroState.initial()); ??
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void completeTask() {
    emit(state.copyWithTask(isCompleted: true));
  }

  List<Task> _sortTasks(List<Task> tasks) {
    return tasks
        .where((task) => task.isPomodoro == true && task.isCompleted == false)
        .toList();
  }
}
