import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/presentation/tags/pages/tags_page.dart';
import 'package:universal_assistant/presentation/tags/widgets/tag_tile.dart';

import '../../../domain/entities/tag.dart';
import '../../../i18n/strings.g.dart';
import '../../../injection.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/tags_cubit.dart';
import '../cubit/tags_state.dart';

class ChangeTagsPage extends StatelessWidget {
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
      child: ChangeTagsView(),
    );
  }
}

class ChangeTagsView extends StatefulWidget {
  const ChangeTagsView({super.key});

  @override
  State<ChangeTagsView> createState() => _ChangeTagsViewState();
}

class _ChangeTagsViewState extends State<ChangeTagsView> {
  @override
  Widget build(BuildContext context) {
    final tags = context.select((TagsCubit cubit) => cubit.state.tags);
    final padding = MediaQuery.of(context).size.width * 0.14;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         context.read<TagsCubit>()
          //           ..saveTags(tags)
          //           ..fetchTags(); //
          //         Navigator.pop(context);
          //         //Navigator.of(context).pushReplacement(SpheresPage.route());
          //       },
          //       icon: const Icon(
          //         Icons.check,
          //         color: Colors.black,
          //       ))
          // ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.of(context,rootNavigator: true).pushReplacement(SpheresPage.route());
              //Navigator.pop(context);
              context.read<HomeCubit>().setTab(HomeTab.tags);
            },
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            t.Parameters,
          ), //style: TextStyle(fontSize: )
        ),
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: EdgeInsets.only(left: padding),
          child: ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final tasksContain =
                  context.read<TagsCubit>().tasksContainTag(tags[index]);
              final eventsContain =
                  context.read<TagsCubit>().eventsContainTag(tags[index]);
              return TagTile(
                sphere: tags[index],
                onDelete: (context) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(t.Attention),
                        content: !tasksContain && !eventsContain
                            ? Text(t.SureDeleteTag)
                            : Column(
                                children: [
                                  Text(t.SureDeleteTag),
                                  tasksContain
                                      ? Text(t.TasksContainTag)
                                      : const SizedBox.shrink(),
                                  eventsContain
                                      ? Text(t.EventsContainTag)
                                      : const SizedBox.shrink(),
                                ],
                              ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.read<TagsCubit>()
                                ..deleteTag(tags[index])..fetchTags();
                              setState(() {
                                //tags.remove(tags[index]);
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              t.Yes,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              t.No,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
