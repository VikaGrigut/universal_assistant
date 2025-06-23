import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/injection.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_state.dart';
import 'package:universal_assistant/presentation/tags/pages/change_tags_page.dart';
import 'package:universal_assistant/presentation/tags/widgets/tag_button.dart';
import 'package:universal_assistant/presentation/tags/widgets/tag_sheet.dart';
import 'package:universal_assistant/presentation/widgets/tab_tasks_events.dart';

import '../../../i18n/strings.g.dart';

class TagsPage extends StatefulWidget {

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {

  @override
  void initState() {
    super.initState();
    context.read<TagsCubit>().fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TagsCubit, TagsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == TagsStatus.failure) {
          print(
              'Что-то пошло не так при отправке запроса.\nПопробуйте, пожалуйста, позже.');
        } else if (state.status == TagsStatus.success) {
          print('Успех');
        }
      },
      child: SpheresView(),
    );
  }
}

class SpheresView extends StatelessWidget {
  const SpheresView({super.key});

  @override
  Widget build(BuildContext context) {
    final spheres = context.select((TagsCubit cubit) => cubit.state.tags);
    print(spheres);
    final selectedIndex =
        context.select((TagsCubit cubit) => cubit.state.selectedTag);
    final events = context.select((TagsCubit cubit) => cubit.state.events);
    final tasks = context.select((TagsCubit cubit) => cubit.state.tasks);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.2,
          actions: [
            IconButton(
              onPressed: (){
                context.read<HomeCubit>().setTab(HomeTab.changeTags);
                },
              icon: Image.asset('assets/icons/parameters.png',height: 25,),
            ),
          ],
          centerTitle: true,
          title: Text(
            t.Tags,
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3, left: 6),
                    child: ElevatedButton(
                        onPressed: () =>
                            context.read<TagsCubit>()..allTags(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == -1
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                        child: Text(
                          t.All,
                          style: TextStyle(
                            color: selectedIndex == -1
                                ? Colors.white
                                : Colors.black,
                          ),
                        )),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      //width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: spheres.length,
                        itemBuilder: (context, index) {
                          return TagButton(
                            sphere: spheres[index],
                            selected: spheres[index].id == selectedIndex
                                ? true
                                : false,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              TabTasksEvents(tasks: tasks, events: events),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            final TextEditingController controller = TextEditingController();
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12),
                                  ),
                                ),
              context: context,
              builder: (context) => Wrap(
                children: [TagSheet(nameController:controller ,)],
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
