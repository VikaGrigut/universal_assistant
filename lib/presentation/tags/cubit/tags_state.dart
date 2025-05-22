import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/tag.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/entities/task.dart';

enum TagsStatus { initial, loading, success, failure }

class TagsState extends Equatable{

  TagsState({
    this.status = TagsStatus.initial,
    this.tasks = const [],
    this.events = const [],
    this.tags = const [],
    this.selectedTag = -1,
});

  final TagsStatus status;
  final List<Task> tasks;
  final List<Event> events;
  final List<Tag> tags;
  final int selectedTag;

  TagsState copyWith({
    TagsStatus? status,
    List<Task>? tasks,
    List<Event>? events,
    List<Tag>? spheres,
    int? selectedSphere,
}) =>
      TagsState(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
        events: events ?? this.events,
        tags: spheres ?? this.tags,
        selectedTag: selectedSphere ?? this.selectedTag,
      );

  @override
  List<Object?> get props => [
        status,
        tags,
        tasks,
        events,
        selectedTag,
  ];

}