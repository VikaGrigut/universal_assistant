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
import '../../i18n/strings.g.dart';
import '../widgets/tag_sheet.dart';
import 'calendar_sheet.dart';

class NewEventSheet extends StatelessWidget {
  NewEventSheet({super.key, required this.nameController, required this.infoController});

   DateTime? date;
  List<int>? time;
  //Priority? priority;
  List<Tag>? tags;

  final TextEditingController nameController;
  final TextEditingController infoController;

  @override
  Widget build(BuildContext context) {
    final selected = context.select((NewEventCubit cubit) => cubit.state.date);
    final currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    const iconSize = 17.0;
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
                  decoration: InputDecoration(
                    hintText: t.Name,
                    hintStyle: const TextStyle(
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
                  decoration: InputDecoration(
                    hintText: t.Description,
                    hintStyle: const TextStyle(
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
                          ? t.Today
                          : DateFormat.yMMMMd().format(selected),
                    ),
                    TaskSheetButton(
                      icon: Image.asset(
                        'assets/icons/hashtag2.png',
                        height: width,
                      ),
                      onPressed: () async{
                        tags = await showModalBottomSheet<List<Tag>>(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) => TagSheet(selectedTags: tags,isNew: false,),
                        );
                      },
                      label: tags == null ? t.Tag : tags!.map((item) => item.name).toString(),
                    ),
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
                        onPressed: () async{
                          context.read<NewEventCubit>()
                            ..changeName(nameController.text)
                            ..changeInfo(infoController.text)
                            ..changeRemindersMessage();
                          final futureResult = context.read<NewEventCubit>().saveNewEvent();
                          futureResult.then((result) {
                            if (!context.mounted) {
                              return;
                            } else {
                              if (result[0] as bool) {
                                nameController.clear();
                                infoController.clear();
                                Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(t.Error),
                                    content: Text(
                                        t.CanNotSaveTask),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text(t.Ok),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          });
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
