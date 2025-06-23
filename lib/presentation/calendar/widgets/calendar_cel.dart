import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';

import '../../utils/date_utils.dart' as date_utils;
import 'dotted_circle.dart';

class CalendarCell extends StatelessWidget {
  const CalendarCell({
    super.key,
    required this.date,
    required this.color,
    this.alive = true,
    this.selected = false,
    this.children = const [],
    this.onTap,
    required this.numberOfActivities,
  });

  final DateTime date;
  final bool alive;
  final bool selected;
  final Color color;
  final List<Widget> children;
  final Function? onTap;
  final int numberOfActivities;

  @override
  Widget build(BuildContext context) {
    if (!alive) {
      return Container(
        decoration: BoxDecoration(
            color: color, shape: BoxShape.circle),
        width: 1,
        height: 1,
        child: const DottedCircleIcon(),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: GestureDetector(
        onTap: ()=>onTap?.call(date),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
             Container(
               width: 40,
               clipBehavior: Clip.none,
               child: DecoratedBox(
                decoration:  BoxDecoration(
                  color: selected ? Colors.deepPurpleAccent : Colors.white,
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.all(Radius.circular(7),)
                    ),
                child: Padding(

                  padding: const EdgeInsets.only(
                    top: 3,
                    right: 9,
                    //bottom: 9,
                    left: 9,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: Text(
                          date_utils.DateUtils.formatDay(
                            date,
                            //locale: Localizations.localeOf(context).languageCode,
                            isTimezone: false,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: selected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -8,
                          bottom: 3,
                          //height: 20,
                          width: 15,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: selected ? Colors.deepPurpleAccent : Colors.white),
                              ),
                          child: numberOfActivities == 0 ? null : Text(numberOfActivities.toString(), style: TextStyle(color: CupertinoColors.black,fontSize: 10),textAlign: TextAlign.center,),))
                    ],
                  ),
                ),
                         ),
             ),
          ],
        ),
      ),
    );
  }
}
