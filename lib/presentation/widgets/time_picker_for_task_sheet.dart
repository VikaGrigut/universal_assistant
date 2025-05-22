import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';

class TimePickerForTaskSheet extends StatefulWidget {
  TimePickerForTaskSheet({super.key,required this.duration});//

  Duration duration;

  @override
  State<TimePickerForTaskSheet> createState() => _TimePickerForTaskSheetState();
}

class _TimePickerForTaskSheetState extends State<TimePickerForTaskSheet> {
  int? hour;
  int? minute;

  @override
  Widget build(BuildContext context) {
    // int selectedHour = widget.hour ?? 9;
    // int selectedMinute = widget.minute ?? 0;
    // final buttonWidth = MediaQuery.of(context).size.width / 2;
    //widget.duration ??= const Duration(hours: 9);
    hour = widget.duration.inHours;
    minute = widget.duration.inMinutes % 60;
    return AlertDialog(
      title: const Text(
        'Выберите время',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       height: 140,
          //       width: 60,
          //       child: CupertinoPicker(
          //         itemExtent: 32,
          //         scrollController: FixedExtentScrollController(
          //             initialItem: selectedHour),
          //         onSelectedItemChanged: (value) => selectedHour = value,
          //         children: List.generate(24, (index) {
          //           return Center(
          //             child: Text(
          //               index.toString().padLeft(2, '0'),
          //               style: const TextStyle(
          //                   fontSize: 20, fontWeight: FontWeight.w400),
          //             ),
          //           );
          //         }),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 140,
          //       width: 60,
          //       child: CupertinoPicker(
          //         itemExtent: 32,
          //         scrollController: FixedExtentScrollController(
          //             initialItem: selectedMinute),
          //         onSelectedItemChanged: (value) => selectedMinute = value,
          //         children: List.generate(60, (index) {
          //           return Center(
          //             child: Text(
          //               index.toString().padLeft(2, '0'),
          //               style: const TextStyle(
          //                   fontSize: 20, fontWeight: FontWeight.w400),
          //             ),
          //           );
          //         }),
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width*0.3,
                child: CupertinoPicker(
                  itemExtent: 32,
                  squeeze: 1.2,
                  scrollController: FixedExtentScrollController(initialItem: widget.duration.inHours),
                  onSelectedItemChanged: (value) {
                    hour = value;
                    print(hour);
                  },
                  children: List.generate(
                    24,
                    (index) {
                      return Text(NumberFormat("00").format(index));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width*0.3,
                child: CupertinoPicker(
                  itemExtent: 32,
                  scrollController: FixedExtentScrollController(initialItem: widget.duration.inMinutes % 60),
                  squeeze: 1.2,
                  onSelectedItemChanged: (value) {
                    minute = value;
                  },
                  children: List.generate(
                    60,
                    (index) {
                      return Text(NumberFormat("00").format(index));
                    },
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   height: 250,
          //   child: CupertinoTimerPicker(
          //     alignment: Alignment.center,
          //     initialTimerDuration: widget.duration!,
          //     mode: CupertinoTimerPickerMode.hm,
          //     onTimerDurationChanged: (newDuration) {
          //       setState(() {
          //         widget.duration = newDuration;
          //       });
          //     },
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          ApplyButton(
            onPressed: () {
              int hours = widget.duration.inHours;
              int minutes = widget.duration.inMinutes % 60;
              context.read<NewTaskCubit>()
                ..changeTime(hour!, minute!)
                ..fetchNewTask();
              // Navigator.pop(context, [selectedHour, selectedMinute]);
              Navigator.pop(context, );//duration
            },
          ),
        ],
      ),
    );
  }
}
