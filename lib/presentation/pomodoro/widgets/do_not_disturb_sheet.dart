import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/do_not_disturb_settings.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/pomodoro/cubit/pomodoro_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/widgets/custom_check_box.dart';

import '../../../i18n/strings.g.dart';

class DoNotDisturbSheet extends StatefulWidget {
  const DoNotDisturbSheet({super.key});

  @override
  State<DoNotDisturbSheet> createState() => _DoNotDisturbSheetState();
}

class _DoNotDisturbSheetState extends State<DoNotDisturbSheet> {
  bool pinning = false;
  bool silent = false;
  TextEditingController intervalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DoNotDisturbSettings settings = context.select((PomodoroCubit cubit) =>
        cubit.state.pomodoroSettings.doNotDisturbSettings);
    pinning = settings.pinningScreen;
    silent = settings.silentMode;
    intervalController.text = settings.timeInterval.toString();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CustomCheckbox(
                  value: pinning,
                  onChanged: (value) {
                    setState(() {
                      pinning = value;
                    });
                  },
                ),
                Text(
                  t.PinningScreen,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                CustomCheckbox(
                  value: silent,
                  onChanged: (value) {
                    setState(() {
                      silent = value;
                    });
                  },
                ),
                Text(
                  t.SilentMode,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  t.TimeOfAction,
                  style: const TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: intervalController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      // hintStyle: const TextStyle(
                      //     //color: Colors.grey,
                      //     ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      focusColor: Colors.grey,
                      hoverColor: Colors.grey,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
                Text(
                  t.MinuteShortened,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            ApplyButton(
              onPressed: () {
                context.read<PomodoroCubit>().changeDoNotDisturbSettings(
                    DoNotDisturbSettings(
                        pinningScreen: pinning,
                        silentMode: silent,
                        timeInterval: int.parse(intervalController.text),
                    ));
                Navigator.pop(context, DoNotDisturbSettings(
                        pinningScreen: pinning,
                        silentMode: silent,
                        timeInterval: int.parse(intervalController.text),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
