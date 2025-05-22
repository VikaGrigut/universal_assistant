import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/domain/entities/event.dart';
import 'package:universal_assistant/domain/entities/task.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeTab? tab}) : super(HomeState(tab: tab ?? HomeTab.calendar));

  void setTab(HomeTab tab) {
    emit(HomeState(tab: tab));
  }
}
