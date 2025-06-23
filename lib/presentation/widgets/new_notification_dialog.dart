import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import 'apply_button.dart';

class NewNotificationDialog extends StatefulWidget {
  NewNotificationDialog({super.key, Duration? duration})
      //: duration = duration ?? const Duration()
  ;

  //Duration duration;

  @override
  State<NewNotificationDialog> createState() => _NewNotificationDialogState();
}

class _NewNotificationDialogState extends State<NewNotificationDialog> {

  int? days = 0;
  int? hours = 0;
  int? minutes = 5;

  @override
  Widget build(BuildContext context) {
    // days = widget.duration.inDays;
    // hours = widget.duration.inHours % 24;
    // minutes = widget.duration.inMinutes % 60;
    final widthPickers = MediaQuery.of(context).size.width / 3 - 20;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  t.RememberFor,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Divider(),
            Row(
              children: [
                // Дни
                SizedBox(
                  height: 140,
                  width: widthPickers,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: days!),
                    itemExtent: 40,
                    onSelectedItemChanged: (value) => days = value,
                    children:
                        List.generate(31, (index) => _pickerItem(index, 'д')),
                  ),
                ),

                // Часы
                SizedBox(
                  height: 140,
                  width: widthPickers,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: hours!),
                    itemExtent: 32,
                    onSelectedItemChanged: (value) => hours = value,
                    children:
                        List.generate(24, (index) => _pickerItem(index, 'ч')),
                  ),
                ),

                // Минуты
                SizedBox(
                  height: 140,
                  width: widthPickers,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: minutes!),
                    itemExtent: 32,
                    onSelectedItemChanged: (value) => minutes = value,
                    children:
                        List.generate(60, (index) => _pickerItem(index, 'мин')),
                  ),
                ),
              ],
            ),
            ApplyButton(onPressed: () {
              final duration = Duration(days: days!,hours: hours!,minutes: minutes!);
              Navigator.pop(context, duration);
            }),
          ],
        ),
      ),
    );
  }
}

Widget _pickerItem(int value, String unit) {
  return Center(
    child: Text(
      "$value $unit",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
  );
}
