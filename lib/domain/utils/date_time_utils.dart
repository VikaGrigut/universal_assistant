

abstract class DateTimeUtils {
  static DateTime currentMonth() {
    final now = DateTime.now();

    return DateTime(now.year, now.month);
  }

  static bool isBeforeMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month < month.month;
    } else {
      return day.isBefore(month);
    }
  }

  static bool isAfterMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month > month.month;
    } else {
      return day.isAfter(month);
    }
  }

  static List<DateTime> daysInWeek(DateTime day, DateTime month) {
    // final firstDay = firstDayOfWeek(day);
    // final lastDay = lastDayOfWeek(day);
    // final first = firstDayOfMonth(day);
    // final daysBefore = first.weekday;
    // final firstToDisplay = first.subtract(Duration(days: daysBefore - 1));
    // final last = lastDayOfMonth(day);
    //
    // final daysAfter = DateTime.daysPerWeek - last.weekday;
    //
    // // if (daysAfter == 0) {
    // //   daysAfter = DateTime.daysPerWeek;
    // // }
    //
    // final lastToDisplay = last.add(Duration(days: daysAfter + 1));

    return daysInRange(firstDayOfWeek(day), lastDayOfWeek(day).add(const Duration(days: 1))).toList();
  }

  static DateTime weekEarlier(DateTime day){
    DateTime newDay = day.subtract(const Duration(days: 7));
    if(day.month != newDay.month ){
      if(lastDayOfWeek(day).day > 7){
        return firstDayOfMonth(DateTime(day.year, day.month));
      }else{
        return lastDayOfMonth(DateTime(newDay.year, newDay.month));
      }
    }
    return newDay;
  }

  static DateTime nextWeek(DateTime day){
    DateTime newDay = day.add(const Duration(days: 7));
    if(day.month != newDay.month ){
      if(firstDayOfWeek(day).day <= lastDayOfMonth(day).subtract(Duration(days: 7)).day){
        return lastDayOfMonth(DateTime(day.year, day.month));
      }else{
        return firstDayOfMonth(DateTime(newDay.year, newDay.month));
      }
    }
    return newDay;
  }

  static List<DateTime> daysInMonth(DateTime month) {
    final first = firstDayOfMonth(month);
    final daysBefore = first.weekday;
    final firstToDisplay = first.subtract(Duration(days: daysBefore - 1));
    final last = lastDayOfMonth(month);

    final daysAfter = DateTime.daysPerWeek - last.weekday;

    // if (daysAfter == 0) {
    //   daysAfter = DateTime.daysPerWeek;
    // }

    final lastToDisplay = last.add(Duration(days: daysAfter + 1));

    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    day = DateTime(day.year, day.month, day.day, 12);

    return day.subtract(Duration(days: day.weekday - 1));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    day = DateTime(day.year, day.month, day.day, 12);

    return day.add(Duration(days: DateTime.daysPerWeek - day.weekday));
  }

  static DateTime lastDayOfMonth(DateTime month) {
    final beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1)
        : DateTime(month.year + 1);

    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  static DateTime lastDayOfMonthWithTime(DateTime month) {
    var monthEnd = lastDayOfMonth(month);

    monthEnd = DateTime(
      monthEnd.year,
      monthEnd.month,
      monthEnd.day,
      23,
      59,
      59,
    );

    return monthEnd;
  }

  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;

    while (i.isBefore(end)) {
      yield i;

      i = i.add(const Duration(days: 1));

      final timeZoneDiff = i.timeZoneOffset - offset;

      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.month == b.month && a.year == b.year;
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.day == b.day && isSameMonth(a, b);
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    a = DateTime(a.year, a.month, a.day);
    b = DateTime(b.year, b.month, b.day);

    final diff = a.difference(b).inDays;

    if (diff.abs() >= DateTime.daysPerWeek) {
      return false;
    }

    final min = a.isBefore(b) ? a : b;
    final max = a.isBefore(b) ? b : a;
    final result = max.weekday % DateTime.daysPerWeek -
            min.weekday % DateTime.daysPerWeek >=
        0;

    return result;
  }

  static DateTime previousMonth(DateTime date) {
    return DateTime(date.year, date.month - 1);
  }

  static DateTime nextMonth(DateTime date) {
    return DateTime(date.year, date.month + 1);
  }
}
