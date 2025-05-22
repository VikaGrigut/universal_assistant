import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/main.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';

class TimePickerForEventSheet extends StatefulWidget {
  TimePickerForEventSheet(
      {super.key, required this.durationStart, required this.durationEnd});

  Duration durationStart;
  Duration durationEnd;

  @override
  State<TimePickerForEventSheet> createState() =>
      _TimePickerForEventSheetState();
}

class _TimePickerForEventSheetState extends State<TimePickerForEventSheet> {
  List<int> startTime = [-1, -1];
  List<int> endTime = [-1, -1];
  bool showStartTime = false;
  bool showEndTime = false;

  @override
  Widget build(BuildContext context) {
    // int selectedHour = widget.hour ?? 9;
    // int selectedMinute = widget.minute ?? 0;
    // final buttonWidth = MediaQuery.of(context).size.width / 2;
    //widget.duration ??= const Duration(hours: 9);
    // startTime = [
    //   widget.durationStart.inHours,
    //   widget.durationStart.inMinutes % 60
    // ];
    // endTime = [widget.durationEnd.inHours, widget.durationEnd.inMinutes % 60];
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
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width * 0.85,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        // text: (startTime[0] == -1 && startTime[1] == -1)
                        //     ? 'От'
                        //     : '${NumberFormat("00").format(startTime[0])}:${startTime[1] == -1 ? NumberFormat("00").format(0) : NumberFormat("00").format(startTime[1])}',
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          alignment: Alignment.center,
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            (startTime[0] == -1 && startTime[1] == -1)
                                ? 'От'
                                : '${NumberFormat("00").format(startTime[0])}:${startTime[1] == -1 ? NumberFormat("00").format(0) : NumberFormat("00").format(startTime[1])}',
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          alignment: Alignment.center,
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            (endTime[0] == -1 && endTime[1] == -1)
                                ? 'До'
                                : '${NumberFormat("00").format(endTime[0])}:${endTime[1] == -1 ? NumberFormat("00").format(0) : NumberFormat("00").format(endTime[1])}',
                          ),
                        ),
                      ),
                    ],
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: CupertinoPicker(
                                itemExtent: 32,
                                squeeze: 1.2,
                                scrollController: FixedExtentScrollController(
                                    initialItem: widget.durationStart.inHours),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    startTime[0] = value;
                                    if (startTime[1] == -1) {
                                      startTime[1] = widget.durationStart.inMinutes%60;
                                    }
                                  });
                                },
                                children: List.generate(
                                  24,
                                  (index) {
                                    return Text(
                                        NumberFormat("00").format(index));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: CupertinoPicker(
                                itemExtent: 32,
                                squeeze: 1.2,
                                scrollController: FixedExtentScrollController(
                                    initialItem:
                                        widget.durationStart.inMinutes % 60),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    startTime[1] = value;
                                    if (startTime[0] == -1) {
                                      startTime[0] = widget.durationStart.inHours;
                                    }
                                  });
                                },
                                children: List.generate(
                                  60,
                                  (index) {
                                    return Text(
                                        NumberFormat("00").format(index));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: CupertinoPicker(
                                itemExtent: 32,
                                squeeze: 1.2,
                                scrollController: FixedExtentScrollController(
                                    initialItem: widget.durationEnd.inHours),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    endTime[0] = value;
                                    if (endTime[1] == -1) {
                                      endTime[1] = widget.durationEnd.inMinutes%60;
                                    }
                                  });
                                },
                                children: List.generate(
                                  24,
                                  (index) {
                                    return Text(
                                        NumberFormat("00").format(index));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: CupertinoPicker(
                                itemExtent: 32,
                                squeeze: 1.2,
                                scrollController: FixedExtentScrollController(
                                    initialItem:
                                        widget.durationEnd.inMinutes % 60),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    endTime[1] = value;
                                    if (endTime[0] == -1) {
                                      endTime[0] = widget.durationEnd.inHours;
                                    }
                                  });
                                },
                                children: List.generate(
                                  60,
                                  (index) {
                                    return Text(
                                        NumberFormat("00").format(index));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
              // int hours = widget.duration!.inHours;
              // int minutes = widget.duration!.inMinutes % 60;
              if (startTime[0] == -1 || startTime[1] == -1) {
                startTime = [
                  widget.durationStart.inHours,
                  widget.durationStart.inMinutes % 60
                ];
              }
              if (endTime[0] == -1 || endTime[1] == -1) {
                endTime = [
                  widget.durationEnd.inHours,
                  widget.durationEnd.inMinutes % 60
                ];
              }
              context.read<NewEventCubit>()
                ..changeTime(startTime, endTime)
                ..fetchNewEvent();
              // Navigator.pop(context, [selectedHour, selectedMinute]);
              Navigator.pop(
                context,
              );
            },
          ),
        ],
      ),
    );
  }
}
