import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_assistant/i18n/strings.g.dart';
import '../../../core/enums/languages.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void fetchHome(){
    final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    LocaleSettings.setLocale(code == 'ru' ? AppLocale.ru : code == 'be' ? AppLocale.be : AppLocale.en);
    emit(state.copyWith(language: code == 'ru' ? Languages.ru : code == 'be' ? Languages.be : Languages.en));
  }

  void setTab(HomeTab tab) {
    emit(state.copyWith(tab: tab));
  }

  void changeLanguage(Languages newLanguage){
    LocaleSettings.setLocale(newLanguage == Languages.ru ? AppLocale.ru : newLanguage == Languages.be ? AppLocale.be : AppLocale.en);
    emit(state.copyWith(language: newLanguage));
  }

  String getLanguageString(){
    final code = state.language;
    return code == Languages.ru  ? 'ru' : code == Languages.be ? 'be' : 'en';
  }
}
//tab: tab ?? HomeTab.calendar {HomeTab? tab}