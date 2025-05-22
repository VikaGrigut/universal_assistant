import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';

import '../../../domain/entities/tag.dart';

class TagButton extends StatelessWidget {
  TagButton({super.key, required this.sphere, required this.selected});

  Tag sphere;
  bool selected;
  //int index;

  @override
  Widget build(BuildContext context) {
    //final name = index == 0 ? 'Все' :sphere.name;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.black : Colors.grey[400],
        ),
        onPressed: () =>
            context.read<TagsCubit>()..changeSelectedTag(sphere),
        //..fetchSpheres(),
        child: Text(
          sphere.name,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
