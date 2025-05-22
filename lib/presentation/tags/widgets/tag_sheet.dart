import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';

class TagSheet extends StatelessWidget {
  TagSheet({super.key,required this.nameController});

  final TextEditingController nameController ;

  @override
  Widget build(BuildContext context) {

    final numOfSpheres =
        context.select((TagsCubit cubit) => cubit.state.tags.length);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: 'Название',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              focusColor: Colors.grey,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<TagsCubit>()
                        ..addTag(
                          Tag(id: numOfSpheres, name: nameController.text),
                        )..fetchTags();
                    },
                    icon: Image.asset(
                      'assets/icons/right.png',
                      height: 45,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
