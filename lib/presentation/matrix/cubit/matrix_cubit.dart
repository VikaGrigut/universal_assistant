import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/core/enums/priority.dart';
import 'package:universal_assistant/presentation/matrix/cubit/matrix_state.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/repositories/event_repository.dart';
import '../../../domain/repositories/task_repository.dart';
import '../../home/cubit/home_cubit.dart';

class MatrixCubit extends Cubit<MatrixState> {
  MatrixCubit({
    required HomeCubit homeCubit,
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        _homeCubit = homeCubit,
        super(MatrixState());

  final TaskRepository _taskRepository;
  final HomeCubit _homeCubit;

  Future<void> fetchMatrix() async {
    emit(state.copyWith(status: MatrixStatus.loading));
    try {
      final tasks = await _taskRepository.getAllTasks();
      print('not yet');
      emit(state.copyWith(
        status: MatrixStatus.initial,
        tasks: tasks,
      ));
    } catch (_) {
      print('error');
      emit(state.copyWith(status: MatrixStatus.failure));
    }
    print('good');
    emit(state.copyWith(status: MatrixStatus.success));
  }

  void changeTask(Task changedTask) {
    List<Task> newList = [];
    if (state.tasks != null && state.tasks!.isNotEmpty) {
      for (var task in state.tasks!) {
        if (task.id == changedTask.id) {
          newList.add(changedTask);
        } else {
          newList.add(task);
        }
      }
      _taskRepository.changeTask(changedTask);
      emit(state.copyWith(tasks: newList));
    }
  }

  List<Task> sortTasks(Priority priority) {
    print('sort ${priority.toString()}');
    return state.tasks == null ? [] : state.tasks!.where((task) => task.priority == priority).toList();

  }
}
