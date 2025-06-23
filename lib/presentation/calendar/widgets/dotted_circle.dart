import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DottedCircleIcon extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color color;

  const DottedCircleIcon({
    Key? key,
    this.size = 0.4,
    this.icon = Icons.add,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: DottedBorder(
        borderType: BorderType.Circle,
        dashPattern: [2, 2],
        strokeWidth: 1,
        radius: Radius.circular(0.7),
        color: color,
        child: Container(
          ),
      ),
    );
  }
}
