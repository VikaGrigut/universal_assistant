import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';
import 'package:universal_assistant/presentation/widgets/apply_button.dart';
import 'package:universal_assistant/presentation/tags/widgets/tag_sheet.dart' as tags_tag_sheet;

import '../calendar/cubit/newEvent/new_event_cubit.dart';
import '../calendar/cubit/newTask/new_task_cubit.dart';

class TagSheet extends StatefulWidget {
  TagSheet({super.key, this.selectedTag, this.isTask = false});

  Tag? selectedTag;
  final bool isTask;
  //String? selectedTag;

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> {
  @override
  Widget build(BuildContext context) {
    final tags2 = context.select((TagsCubit cubit) => cubit.tags);
    final tags = ['meow', 'wof', 'mow', 'car', 'pe'];
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 15, bottom: 7),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Теги',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tags2 == null ? 0 : tags2.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: tags2![index] == widget.selectedTag
                                ? true
                                : false,
                            checkColor: Colors.black,
                            fillColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.black;
                              }
                              return null;
                            }),
                            shape: const CircleBorder(),
                            onChanged: (value) {
                              if (value == true) {
                                widget.selectedTag = tags2[index];
                              }
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            tags2[index].name,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  final TextEditingController controller =
                      TextEditingController();
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    context: context,
                    builder: (context) => Wrap(
                      children: [
                        tags_tag_sheet.TagSheet(
                          nameController: controller,
                        )
                      ],
                    ),
                  );
                },
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ApplyButton(onPressed: () {
              Navigator.pop(context, widget.selectedTag);
              if(widget.selectedTag != null){
                widget.isTask ? context.read<NewTaskCubit>().changeTag(widget.selectedTag!) : context.read<NewEventCubit>().changeTag(widget.selectedTag!);
              }
            }),
          ],
        ),
      ),
    );
  }
}
