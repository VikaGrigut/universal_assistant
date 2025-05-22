
part of 'home_cubit.dart';


enum HomeTab {
  calendar,
  tags,
  matrix,
  menu,
  pomodoro,
  changeTags,
  recurring,
}

class HomeState extends Equatable {
  const HomeState({
    required this.tab,
    // this.tasks = const [],
    // this.events = const [],
  });

  final HomeTab tab;
  // final List<Event> events;
  // final List<Task> tasks;

  @override
  List<Object> get props => [
      tab,
      // tasks,
      // events,
  ];
}
