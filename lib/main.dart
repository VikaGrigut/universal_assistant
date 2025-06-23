import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:universal_assistant/injection.dart';
import 'package:universal_assistant/presentation/calendar/cubit/calendar/calendar_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/editTask/edit_task_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/home/pages/home_page.dart';
import 'package:universal_assistant/presentation/matrix/cubit/matrix_cubit.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_cubit.dart';
import 'package:universal_assistant/presentation/recurring/cubit/recurring_cubit.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';
import 'data/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'i18n/strings.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  tz.initializeTimeZones();

  await NotificationService().initialize();
  await initializeDateFormatting('ru_RU', null);

  await init();
  final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  await LocaleSettings.setLocale(code == 'ru' ? AppLocale.ru : code == 'be' ? AppLocale.be : AppLocale.en);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator.get<CalendarCubit>()),
        BlocProvider.value(value: locator.get<NewTaskCubit>()),
        BlocProvider.value(value: locator.get<EditTaskCubit>()),
        BlocProvider.value(value: locator.get<HomeCubit>()),
        BlocProvider.value(value: locator.get<MatrixCubit>()),
        BlocProvider.value(value: locator.get<TagsCubit>()),
        BlocProvider.value(value: locator.get<NewEventCubit>()),
        BlocProvider.value(value: locator.get<PomodoroCubit>()),
        BlocProvider.value(value: locator.get<RecurringCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        supportedLocales: const [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
          Locale('be', 'BE'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}


