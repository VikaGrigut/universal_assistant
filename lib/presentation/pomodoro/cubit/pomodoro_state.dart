import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/do_not_disturb_settings.dart';
import 'package:universal_assistant/domain/entities/pomodoro_settings.dart';
import 'package:universal_assistant/domain/entities/task.dart';

enum PomodoroStatus { initial, loading, success, failure }

enum PomodoroMode { work, shortBreak, longBreak }

class PomodoroState extends Equatable {
  PomodoroState(
      {this.pomodoroTasks = const [],
      this.status = PomodoroStatus.initial,
      this.currentTask,
      this.isRunning = false,
      int? duration,
      this.completedCycles = 0,
      this.mode = PomodoroMode.work,
      PomodoroSettings? pomodoroSettings})
      : pomodoroSettings = pomodoroSettings ??
            const PomodoroSettings(
              numOfPomo: 4,
              durationPomo: 25,
              shortBreak: 5,
              longBreak: 15,
              doNotDisturbSettings: DoNotDisturbSettings(
                pinningScreen: false,
                silentMode: false,
                timeInterval: 0,
              ),
            ),
          duration = duration ?? (pomodoroSettings != null ? pomodoroSettings.durationPomo*60 : 25*60);

  final PomodoroStatus status;
  final PomodoroSettings pomodoroSettings;
  final List<Task> pomodoroTasks;
  final Task? currentTask;
  final int duration;
  final PomodoroMode mode;
  final int completedCycles;
  final bool isRunning;
  //final DoNotDisturbSettings doNotDisturbSettings; //???

  PomodoroState copyWith({
    PomodoroStatus? status,
    PomodoroSettings? pomodoroSettings,
    List<Task>? pomodoroTasks,
    Task? currentTask,
    int? duration,
    PomodoroMode? mode,
    int? completedCycles,
    bool? isRunning,
  }) =>
      PomodoroState(
        status: status ?? this.status,
        pomodoroSettings: pomodoroSettings ?? this.pomodoroSettings,
        pomodoroTasks: pomodoroTasks ?? this.pomodoroTasks,
        currentTask: currentTask ?? this.currentTask,
        duration: duration ?? this.duration,
        mode: mode ?? this.mode,
        completedCycles: completedCycles ?? this.completedCycles,
        isRunning: isRunning ?? this.isRunning,
      );

  PomodoroState copyWithTask({bool? isCompleted}) => copyWith(
          currentTask: Task(
        id: currentTask!.id,
        name: currentTask!.name,
        allDay: currentTask!.allDay,
        repetition: currentTask!.repetition,
        periodicity: currentTask!.periodicity,
        date: currentTask!.date,
        priority: currentTask!.priority,
        reminder: currentTask!.reminder,
        tags: currentTask!.tags,
        info: currentTask!.info,
        isPomodoro: currentTask!.isPomodoro,
        isCompleted: isCompleted ?? currentTask!.isCompleted,
      ));

  @override
  List<Object?> get props => [
        status,
        pomodoroSettings,
        pomodoroTasks,
        currentTask,
        duration,
        mode,
        completedCycles,
        isRunning,
      ];
}
