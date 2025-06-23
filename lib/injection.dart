import 'package:get_it/get_it.dart';
import 'package:universal_assistant/data/repositories/event_repository_impl.dart';
import 'package:universal_assistant/data/repositories/settings_repository_impl.dart';
import 'package:universal_assistant/data/repositories/tag_repository_impl.dart';
import 'package:universal_assistant/data/repositories/task_repository_impl.dart';
import 'package:universal_assistant/domain/repositories/event_repository.dart';
import 'package:universal_assistant/domain/repositories/settings_repository.dart';
import 'package:universal_assistant/domain/repositories/tag_repository.dart';
import 'package:universal_assistant/domain/repositories/task_repository.dart';
import 'package:universal_assistant/presentation/calendar/cubit/calendar/calendar_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/editTask/edit_task_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/matrix/cubit/matrix_cubit.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_cubit.dart';
import 'package:universal_assistant/presentation/recurring/cubit/recurring_cubit.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(() => CalendarCubit(
        homeCubit: locator(),
        eventRepository: locator(),
        taskRepository: locator(),
      ));

  locator.registerLazySingleton(() => TagsCubit(
        homeCubit: locator(),
        tagsRepository: locator(),
        eventRepository: locator(),
        taskRepository: locator(),
      ));

  locator.registerLazySingleton(() => HomeCubit());

  locator.registerLazySingleton(() => PomodoroCubit(
        taskRepository: locator(),
        settingRepository: locator(),
      ));

  locator.registerLazySingleton(() => RecurringCubit(
        taskRepository: locator(),
        eventRepository: locator(),
      ));

  locator.registerLazySingleton(() => NewTaskCubit(
        homeCubit: locator(),
        taskRepository: locator(),
        tagRepository: locator(),
      ));

  locator.registerLazySingleton(() => EditTaskCubit(
        homeCubit: locator(),
        taskRepository: locator(),
        tagRepository: locator(),
      ));

  locator.registerLazySingleton(
    () => MatrixCubit(homeCubit: locator(), taskRepository: locator()),
  );

  locator.registerLazySingleton(
    () => NewEventCubit(
        homeCubit: locator(),
        eventRepository: locator(),
        tagRepository: locator()),
  );

  locator.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl());

  locator.registerLazySingleton<EventRepository>(() => EventRepositoryImpl());

  locator.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  locator.registerLazySingleton<TagRepository>(() => TagRepositoryImpl());
}
