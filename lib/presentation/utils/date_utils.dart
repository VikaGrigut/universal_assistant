import 'package:intl/intl.dart';

import '../../i18n/strings.g.dart';

abstract class DateUtils {
  static List<Function> weekdays = [
    () => t.Monday,
    () => t.Tuesday,
    () => t.Wednesday,
    () => t.Thursday,
    () => t.Friday,
    () => t.Saturday,
    () => t.Sunday,
  ];

  static String formatMonthWithYear(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate = /*isTimezone ? DateTimeProvider.from(date) :*/ date;
    final month = DateFormat('MMMM', locale).format(timezoneDate);
    return '${month[0].toUpperCase()}${month.substring(1)} ${date.year}';
  }

  static String formatDay(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate = /*isTimezone ? DateTimeProvider.from(date) : */date;
    return DateFormat('dd').format(timezoneDate);
  }

  static String formatYear(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate = /*isTimezone ? DateTimeProvider.from(date) : */date;
    return DateFormat.y(locale).format(timezoneDate);
  }

  static String formatDayWithMonth(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate = /*isTimezone ? DateTimeProvider.from(date) :*/ date;
    return DateFormat('d MMMM', locale).format(timezoneDate);
  }

  static String formatDate(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate = /*isTimezone ? DateTimeProvider.from(date) :*/ date;
    return DateFormat.yMd('ru_RU').format(timezoneDate);
  }

  static String formatShortDate(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate =/* isTimezone ? DateTimeProvider.from(date) :*/ date;
    return DateFormat.Md(locale).format(timezoneDate);
  }

  static String formatTime(
    DateTime date, {
    String? locale,
    bool isTimezone = true,
  }) {
    final timezoneDate = /*isTimezone ? DateTimeProvider.from(date) :*/ date;
    return DateFormat.Hm(locale).format(timezoneDate);
  }
}