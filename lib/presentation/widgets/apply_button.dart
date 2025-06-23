import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';

class ApplyButton extends StatelessWidget {
  ApplyButton({super.key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width - 30;
    return ElevatedButton(
                onPressed: () => onPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(buttonSize, 10),
                ),
                child: Text(
                  t.Apply,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
  }
}
