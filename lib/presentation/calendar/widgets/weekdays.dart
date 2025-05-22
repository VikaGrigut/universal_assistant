import 'package:flutter/cupertino.dart';

import '../../utils/date_utils.dart';

class Weekdays extends StatelessWidget {
  const Weekdays({super.key});

  @override
  Widget build(BuildContext context) {
    final weekdaysCount = DateUtils.weekdays.length;
    final itemWidth = MediaQuery.of(context).size.width / weekdaysCount;

    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 1),
        itemCount: weekdaysCount,
        itemBuilder: (context, index) => SizedBox(
          width: itemWidth-2,
          child: Text(
            DateUtils.weekdays[index],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
        ),
      ),
    );
  }
}
