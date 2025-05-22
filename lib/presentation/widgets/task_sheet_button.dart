import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../domain/utils/date_time_utils.dart';

class TaskSheetButton extends StatelessWidget {
  const TaskSheetButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  final Widget icon;
  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textSize = MediaQuery.of(context).size.width / 30;
    return Wrap(
      children: [
        ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: icon,
        onPressed: () => onPressed(),
        label: Text(
          label,
          style: TextStyle(
              fontSize: textSize, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      )
      ],
    );
  }
}
