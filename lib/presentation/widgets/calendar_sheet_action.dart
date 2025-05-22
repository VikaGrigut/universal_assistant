import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarSheetAction extends StatelessWidget {
  const CalendarSheetAction({
    super.key,
    required this.onPressed,
    this.icon,
    required this.text,
  });

  final Function onPressed;
  final Widget? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon ?? const SizedBox.shrink(),
              const SizedBox(
                width: 7,
              ),
              Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          Image.asset(
            'assets/icons/next3.png',
            height: 25,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
