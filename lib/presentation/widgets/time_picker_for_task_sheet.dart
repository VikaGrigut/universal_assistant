import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';

import '../../i18n/strings.g.dart';
import '../calendar/cubit/editTask/edit_task_cubit.dart';

class TimePickerForTaskSheet extends StatefulWidget {
  TimePickerForTaskSheet({super.key,required this.duration,required this.isNew});//

  Duration duration;
  bool isNew;

  @override
  State<TimePickerForTaskSheet> createState() => _TimePickerForTaskSheetState();
}

class _TimePickerForTaskSheetState extends State<TimePickerForTaskSheet> {
  int? hour;
  int? minute;

  @override
  Widget build(BuildContext context) {
    hour = widget.duration.inHours;
    minute = widget.duration.inMinutes % 60;
    return AlertDialog(
      title: Text(
        t.SelectTime,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
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
          const SizedBox(
            height: 10,
          ),
          ApplyButton(
            onPressed: () {
              int hours = widget.duration.inHours;
              int minutes = widget.duration.inMinutes % 60;
              widget.isNew ? (context.read<NewTaskCubit>()
                ..changeTime(hour!, minute!)
                ..fetchNewTask()):(context.read<EditTaskCubit>()
                ..changeTime(hour!, minute!)..fetchEditTask()
                );
              Navigator.pop(context, );//duration
            },
          ),
        ],
      ),
    );
  }
}
