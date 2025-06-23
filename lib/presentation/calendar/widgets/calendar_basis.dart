import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:universal_assistant/presentation/calendar/cubit/calendar/calendar_cubit.dart';
import 'package:universal_assistant/presentation/calendar/widgets/weekdays.dart';

import '../../../domain/utils/date_time_utils.dart';

class CalendarBasis extends StatelessWidget {
  CalendarBasis(
      {super.key,
      this.expanded,
      this.collapsed,
      this.onSwipe,
      required this.month});

  DateTime month;
  Widget? collapsed;
  Widget? expanded;
  Function? onSwipe;
  Widget? expandedWithButtons;

  @override
  Widget build(BuildContext context) {
    if (expanded != null) {
      expandedWithButtons = Column(
        children: [
          expanded!,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black,width: 1.5),
                  ),
                  child: IconButton(
                      onPressed: _previousMonth,
                      icon: Image.asset(
                        'assets/icons/previous.png',
                        //height: 20,
                      )),
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black,width: 1.5),
                  ),
                  child: IconButton(
                      onPressed: _nextMonth,
                      icon: Image.asset(
                        'assets/icons/next3.png',
                        //height: 21,
                      )),
                )
              ],
            ),
          )
        ],
      );
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: DecoratedBox(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(7)),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.inactiveGray,
                    blurRadius: 6,
                    blurStyle: BlurStyle.outer,
                  ),
                ]),
            child: Column(
              children: [
                const Weekdays(),
                GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) =>
                        details.velocity.pixelsPerSecond.dx > 0
                            ? _previousMonth()
                            : _nextMonth(),
                    child: expandedWithButtons ?? collapsed)
              ],
            )));
  }

  void _previousMonth() {
    final previousMonth = DateTimeUtils.previousMonth(month);
    onSwipe?.call(previousMonth);
  }

  void _nextMonth() {
    final nextMonth = DateTimeUtils.nextMonth(month);
    onSwipe?.call(nextMonth);
  }
}
