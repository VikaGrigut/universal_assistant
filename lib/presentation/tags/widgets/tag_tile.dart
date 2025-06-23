import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_cubit.dart';

import '../../../domain/entities/tag.dart';

class TagTile extends StatelessWidget {
  TagTile({super.key, required this.sphere, this.onDelete});

  Tag sphere;
  Function? onDelete;

  @override
  Widget build(BuildContext context) {
    final spheres = context.select((TagsCubit cubit) => cubit.state.tags);//symmetric(horizontal: 5, vertical: 10),
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(5),
              onPressed: (context) => onDelete?.call(context),//spheres.remove(sphere),
              icon: Icons.delete,
              backgroundColor: Colors.black,
            )
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7)),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.inactiveGray,
                  blurRadius: 6,
                  blurStyle: BlurStyle.outer,
                ),
              ]),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 5),//horizontal: 7,
              child: Text(
                sphere.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
