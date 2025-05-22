import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/repositories/tag_repository.dart';
import 'package:universal_assistant/presentation/home/cubit/home_cubit.dart';
import 'package:universal_assistant/presentation/tags/cubit/tags_state.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/repositories/event_repository.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../../domain/repositories/task_repository.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit({
    required TagRepository tagsRepository,
    required HomeCubit homeCubit,
    required EventRepository eventRepository,
    required TaskRepository taskRepository,
  })  : _tagsRepository = tagsRepository,
        _taskRepository = taskRepository,
        _eventRepository = eventRepository,
        _homeCubit = homeCubit,
        super(TagsState());

  final TagRepository _tagsRepository;
  final EventRepository _eventRepository;
  final TaskRepository _taskRepository;
  final HomeCubit _homeCubit;
  List<Tag>? tags = [];
  List<Event>? events;
  List<Task>? tasks;

  Future<void> fetchTags() async {
    emit(state.copyWith(status: TagsStatus.loading));
    try {
      events = await _eventRepository.getAllEvents() ?? [];
      tasks = await _taskRepository.getAllTasks() ?? [];
      tags = await _tagsRepository.getAllTags();

      emit(state.copyWith(
        status: TagsStatus.initial,
        spheres: tags,
        events: events,
        tasks: tasks,
      ));
    } catch (_) {
      emit(state.copyWith(status: TagsStatus.failure));
    }
    emit(state.copyWith(status: TagsStatus.success));
  }

  Future<void> changeSelectedTag(Tag sphere) async {
    emit(state.copyWith(
      selectedSphere: sphere.id,
      events: _sortEvents(events!, sphere),
      tasks: _sortTasks(tasks!, sphere),
    ));
  }

  void allTags() {
    emit(state.copyWith(
      selectedSphere: -1,
      events: events,
      tasks: tasks,
    ));
  }

  void addTag(Tag tag)async{
    final result = _tagsRepository.addTag(tag);
    print(result);
    tags!.add(tag);
    emit(state.copyWith(spheres: tags));
    //await fetchSpheres();
  }
  
  void deleteTag(int tagId)async{
    final result = _tagsRepository.deleteTag(tagId);
    print(result);
    tags!.removeWhere((Tag tag) => tag.id == tagId);
    emit(state.copyWith(spheres: tags));
    //await fetchSpheres();
  }

  void saveTags(List<Tag> tags){
    final result = _tagsRepository.saveTags(tags);
    print(result);
    //spheres!.add(sphere);
    emit(state.copyWith(spheres: tags));
  }

  List<Event> _sortEvents(List<Event> events, Tag sphere) {
    return events.where((event) => event.tag == sphere).toList();
  }

  List<Task> _sortTasks(List<Task> tasks, Tag sphere) {
    return tasks.where((task) => task.tag == sphere).toList();
  }
}
