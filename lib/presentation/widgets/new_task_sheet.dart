import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/domain/utils/date_time_utils.dart';
import 'package:universal_assistant/presentation/calendar/cubit/newTask/new_task_cubit.dart';
import 'package:universal_assistant/presentation/widgets/calendar_sheet.dart';
import 'package:universal_assistant/presentation/widgets/notification_dialog.dart';
import 'package:universal_assistant/presentation/widgets/priority_sheet.dart';
import 'package:universal_assistant/presentation/widgets/tag_sheet.dart';
import 'package:universal_assistant/presentation/widgets/task_sheet_button.dart';
import 'package:universal_assistant/presentation/widgets/time_picker_for_task_sheet.dart';

import '../../domain/entities/tag.dart';
import '../../i18n/strings.g.dart';
import '../calendar/cubit/calendar/calendar_cubit.dart';
import '../calendar/cubit/editTask/edit_task_cubit.dart';

class NewTaskSheet extends StatelessWidget {
  NewTaskSheet(
      {super.key,
      required this.nameController,
      required this.infoController,
      bool? isNew})
      : isNew = isNew ?? false;
  DateTime? date;
  List<int>? time;
  Priority? priority;
  List<Tag>? tags;
  bool isNew;

  final TextEditingController nameController;
  final TextEditingController infoController;

  @override
  Widget build(BuildContext context) {
    context.read<NewTaskCubit>().fetchNewTask();
    final selected = isNew ? context.select((NewTaskCubit cubit) => cubit.state.date) : context.select((EditTaskCubit cubit) => cubit.state.date);
    final currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    const iconSize = 17.0;
    if(!isNew){
      nameController.text = context.select((EditTaskCubit cubit) => cubit.state.task.name);
      infoController.text = context.select((EditTaskCubit cubit) => cubit.state.task.info);
      date = selected;
    }
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
                            isTask: true,
                            isNew: isNew,
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
                      onPressed: () async {
                        tags = await showModalBottomSheet<List<Tag>>(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) => TagSheet(
                            selectedTags: tags,
                            isTask: true,
                            isNew: isNew
                          ),
                        );
                      },
                      label: tags == null
                          ? t.Tag
                          : tags!.map((item) => item.name).toString(),
                    ),
                    TaskSheetButton(
                      icon: Image.asset(
                        'assets/icons/flag2.png',
                        height: width,
                      ),
                      onPressed: () async {
                        priority = await showModalBottomSheet<Priority>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) => PrioritySheet(isNew: isNew,),
                        );
                        //checkBoxStatuses[index!] = true;
                      },
                      label: priority == null
                          ? t.Priority
                          : getPriorityText(priority!),
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
                        onPressed: () {
                          isNew ? (context.read<NewTaskCubit>()
                            ..changeName(nameController.text)
                            ..changeInfo(infoController.text)
                            ..changeReminderMessage()):(context.read<EditTaskCubit>()
                            ..changeName(nameController.text)
                            ..changeInfo(infoController.text)
                            ..changeReminderMessage());
                          // if(tag != null){
                          //   context.read<NewTaskCubit>().changeTag(tag!);
                          // }
                          final futureResult =
                              isNew ? context.read<NewTaskCubit>().saveNewTask():context.read<EditTaskCubit>().saveEditTask();
                          futureResult.then((result) {
                            if (!context.mounted) {
                              return;
                            } else {
                              if (result[0] as bool) {
                                nameController.clear();
                                infoController.clear();
                                context.read<CalendarCubit>().fetchCalendar();
                                Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(t.Error),
                                    content: Text(t.CanNotSaveTask),
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
