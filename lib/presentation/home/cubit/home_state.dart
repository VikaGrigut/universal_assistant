part of 'home_cubit.dart';

enum HomeTab {
  calendar,
  tags,
  matrix,
  menu,
  pomodoro,
  pomodoroSettings,
  changeTags,
  recurring,
}

class HomeState extends Equatable {
  const HomeState({
    HomeTab? tab,
    Languages? language,
  }): tab = tab ?? HomeTab.calendar, language = language ?? Languages.ru;

  final HomeTab tab;
  final Languages language;

  HomeState copyWith({
    HomeTab? tab,
    Languages? language,
  }) =>
      HomeState(
        tab: tab ?? this.tab,
        language: language ?? this.language,
      );

  @override
  List<Object> get props => [
        tab,
        language,
      ];
}
