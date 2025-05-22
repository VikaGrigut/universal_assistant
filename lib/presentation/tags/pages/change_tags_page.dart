import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/presentation/tags/pages/tags_page.dart';
import 'package:universal_assistant/presentation/tags/widgets/tag_tile.dart';

import '../../../domain/entities/tag.dart';
import '../../../injection.dart';
import '../cubit/tags_cubit.dart';
import '../cubit/tags_state.dart';

class ChangeTagsPage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<TagsCubit>(
        create: (_) => TagsCubit(
          tagsRepository: locator(),
          eventRepository: locator(),
          taskRepository: locator(),
          homeCubit: locator(),
        )..fetchTags(),
        child: ChangeTagsPage(),
      ),
    );
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<TagsCubit>()..saveTags(tags)..fetchTags();//
                  Navigator.pop(context);
                  //Navigator.of(context).pushReplacement(SpheresPage.route());
                  },
                icon: const Icon(
                  Icons.check,
                  color: Colors.black,
                ))
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              //Navigator.of(context,rootNavigator: true).pushReplacement(SpheresPage.route());
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          centerTitle: true,
          title: const Text(
            'Параметры',
          ), //style: TextStyle(fontSize: )
        ),
        backgroundColor: Colors.grey[300],
        body: ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, index){
            return TagTile(sphere: tags[index],onDelete: (context){
              //context.read<TagsCubit>().deleteTag(tags[index].id);
              setState(() {
                tags.remove(tags[index]);
              });
            },);
          },
        ),
      ),
    );
  }
}
