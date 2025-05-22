import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newEvent/new_event_cubit.dart';
import 'package:universal_assistant/presentation/widgets/priority_sheet.dart';
import 'package:universal_assistant/presentation/widgets/task_sheet_button.dart';

import '../../core/enums/priority.dart';
import '../../domain/entities/tag.dart';
import '../../domain/utils/date_time_utils.dart';
import '../widgets/tag_sheet.dart';
import 'calendar_sheet.dart';

class NewEventSheet extends StatelessWidget {
  NewEventSheet({super.key, required this.nameController, required this.infoController});

   DateTime? date;
  List<int>? time;
  //Priority? priority;
  Tag? tag;

  final TextEditingController nameController;
  final TextEditingController infoController;

  @override
  Widget build(BuildContext context) {
    final selected = context.select((NewEventCubit cubit) => cubit.state.date);
    final currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    const iconSize = 17.0;
    // final priorityCubit =
    //     context.select((NewEventCubit cubit) => cubit.state.event.);
    final width = MediaQuery.of(context).size.width / 23;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Название',
                    hintStyle: TextStyle(
                        //color: Colors.grey,
                        ),
                    focusColor: Colors.grey,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: infoController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Описание',
                    hintStyle: TextStyle(
                      fontSize: 10,
                      //color: Colors.grey[400],
                    ),
                    focusColor: Colors.grey,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TaskSheetButton(
                      icon: SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        height: iconSize,
                      ),
                      onPressed: () async {
                        date = await showModalBottomSheet<DateTime>(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) => CalendarSheet(
                            selectedDate: date ?? selected,
                          ),
                        );
                        date ??= selected;
                        print(date);
                      },
                      label: DateTimeUtils.isSameDay(selected, DateTime.now())
                          ? 'Сегодня'
                          : DateFormat.yMMMMd().format(selected),
                    ),
                    // DecoratedBox(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       //border: Border.all(color: Colors.black),
                    //       color: Colors.grey),
                    //   child: Row(
                    //     children: [
                    //       ,
                    //       // const SizedBox(
                    //       //   width: 10,
                    //       // )
                    //     ],
                    //   ),
                    // ),
                    // DecoratedBox(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.black)),
                    //     child: IconButton(
                    //         icon: const Icon(
                    //           Icons.access_time,
                    //           size: buttonSize,
                    //         ),
                    //         onPressed: () async {
                    //           time = await showModalBottomSheet<List<int>>(
                    //             shape: const RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.vertical(
                    //                 top: Radius.circular(12),
                    //               ),
                    //             ),
                    //             backgroundColor: Colors.white,
                    //             context: context,
                    //             builder: (BuildContext context) =>
                    //                 TimePickerSheet(
                    //               hour: time?[0],
                    //               minute: time?[1],
                    //             ),
                    //           );
                    //           print(time);
                    //         })),
                    // DecoratedBox(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.black)),
                    //     child: IconButton(
                    //         icon: SvgPicture.asset(
                    //           'assets/icons/notification.svg',
                    //           height: buttonSize,
                    //         ),
                    //         onPressed: () {
                    //           // showModalBottomSheet<List<int>>(
                    //           //   shape: const RoundedRectangleBorder(
                    //           //     borderRadius: BorderRadius.vertical(
                    //           //       top: Radius.circular(12),
                    //           //     ),
                    //           //   ),
                    //           //   backgroundColor: Colors.white,
                    //           //   context: context,
                    //           //   builder: (BuildContext context) =>
                    //           //       NotificationSheet(),
                    //           // );
                    //         })),
                    // DecoratedBox(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.black)),
                    //     child: IconButton(
                    //),
                    TaskSheetButton(
                      icon: Image.asset(
                        'assets/icons/hashtag2.png',
                        height: width,
                      ),
                      onPressed: () async{
                        tag = await showModalBottomSheet<Tag>(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) => TagSheet(selectedTag: tag,),
                        );
                      },
                      label: tag == null ? 'Тег' : tag!.name,
                    ),
                    // TaskSheetButton(
                    //   icon: Image.asset(
                    //     'assets/icons/flag2.png',
                    //     height: width,
                    //   ),
                    //   onPressed: () async {
                    //     priority = await showModalBottomSheet<Priority>(
                    //       shape: const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(12),
                    //         ),
                    //       ),
                    //       backgroundColor: Colors.white,
                    //       context: context,
                    //       builder: (BuildContext context) => PrioritySheet(),
                    //     );
                    //     //checkBoxStatuses[index!] = true;
                    //   },
                    //   label: priority == null
                    //       ? 'Приоритет'
                    //       : getPriorityText(priority!),
                    // ),
                    // DecoratedBox(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(color: Colors.black)),
                    //     child: IconButton(
                    //         icon: SvgPicture.asset(
                    //           'assets/icons/rotate-reverse.svg',
                    //           height: buttonSize,
                    //         ),
                    //         onPressed: () {})),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.read<NewEventCubit>()
                            ..changeName(nameController.text)
                            ..changeInfo(infoController.text);
                          // if(tag != null){
                          //   context.read<NewEventCubit>().changeTag(tag!);
                          // }
                          final result = context.read<NewEventCubit>().saveNewEvent();
                          print(result);
                          nameController.clear();
                          infoController.clear();
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          'assets/icons/submit.png',
                          height: 45,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
