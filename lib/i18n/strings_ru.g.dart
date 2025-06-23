///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override String get Calendar => 'Календарь';
	@override String get Tasks => 'Задачи';
	@override String get Events => 'События';
	@override String get NoTasks => 'Пока нет запланированных задач';
	@override String get NoEvents => 'Пока нет запланированных событий';
	@override String get NoTags => 'Пока нет тегов';
	@override String get Change => 'Изменить';
	@override String get Attention => 'Внимание!';
	@override String get SureDeleteTask => 'Вы уверены, что хотите удалить задачу?';
	@override String get SureDeleteEvent => 'Вы уверены, что хотите удалить событие?';
	@override String get SureDeleteTag => 'Вы уверены, что хотите удалить тег?';
	@override String get TasksContainTag => 'Некоторые задачи содержат этот тег';
	@override String get EventsContainTag => 'Некоторые события содержат этот тег';
	@override String get Yes => 'Да';
	@override String get No => 'Нет';
	@override String get Matrix => 'Матрица Эйзенхауэре';
	@override String get Menu => 'Меню';
	@override String get Main => 'Главная';
	@override String get Tags => 'Мои теги';
	@override String get RecurringTasks => 'Повторяющиеся задачи';
	@override String get PomodoroTimer => 'PomodoroTimer';
	@override String get Settings => 'Настройки';
	@override String get Work => 'Работа';
	@override String get Break => 'Перерыв';
	@override String get NoSuitableTasks => 'Нет подходящих задач';
	@override String get SelectTask => 'Выбрать задачу';
	@override String get RecurringTasksEvents => 'Повторяющиеся задачи и события';
	@override String get Parameters => 'Параметры';
	@override String get All => 'Все';
	@override String get Apply => 'Применить';
	@override String get SelectDate => 'Выберите дату';
	@override String get AddTime => 'Добавить время';
	@override String get Everyday => 'Ежедневно';
	@override String get EveryWeek => 'Каждую @{number}-ю неделю:';
	@override String get EveryMonth => 'Ежемесячно @{date} числа';
	@override String get Repeat => 'Повторять';
	@override String get AtStartTime => 'На время начала';
	@override String get DurationUpTo => 'Длительность до';
	@override String get Name => 'Название';
	@override String get Description => 'Описание';
	@override String get Today => 'Сегодня';
	@override String get Tag => 'Тег';
	@override String get RememberFor => 'Напомнить за';
	@override String get NumOfPomo => 'Количество pomo';
	@override String get DurationPomo => 'Длительность pomo';
	@override String get ShortBreak => 'Маленький перерыв';
	@override String get LongBreak => 'Большой перерыв';
	@override String get DoNotDisturb => 'Не беспокоить';
	@override String get Priority => 'Приоритет';
	@override String get Error => 'Ошибка';
	@override String get CanNotSaveTask => 'Невозможно сохранить задачу!\nПроверьте заполненные данные.';
	@override String get Ok => 'ОK';
	@override String get Reminder => 'Напоминания';
	@override String get Add => 'Добавить';
	@override String get SelectPriority => 'Выберите приоритет';
	@override String get ImportantAndUrgent => 'Важно и срочно';
	@override String get ImportantAndNotUrgent => 'Важно, но не срочно';
	@override String get NotImportantAndUrgent => 'Не важно, но срочно';
	@override String get NotImportantAndNotUrgent => 'Не важно и не срочно';
	@override late final _TranslationsForMatrixRu ForMatrix = _TranslationsForMatrixRu._(_root);
	@override String get Day => 'День';
	@override String get Week => 'Неделя';
	@override String get Month => 'Месяц';
	@override String get Duration => 'Длительность';
	@override String get Interval => 'Интервал';
	@override String get RepetitionDatePrecedesTaskDate => 'Дата окончания повторения предшествует дате задачи';
	@override String get Clear => 'Понятно';
	@override String get SelectDaysOfRepeatWeek => 'Выберите дни недели повторения';
	@override String get SelectInterval => 'Выберите интервал';
	@override String get SelectTime => 'Выберите время';
	@override String get SelectLanguage => 'Выберите язык';
	@override String get From => 'От';
	@override String get To => 'До';
	@override String get In => 'За';
	@override String get DayShortened => 'д';
	@override String get HoursShortened => 'ч';
	@override String get MinuteShortened => 'мин';
	@override String get Monday => 'Пн';
	@override String get Tuesday => 'Вт';
	@override String get Wednesday => 'Ср';
	@override String get Thursday => 'Чт';
	@override String get Friday => 'Пт';
	@override String get Saturday => 'Сб';
	@override String get Sunday => 'Вс';
	@override String get Save => 'Сохранить';
	@override String get Delete => 'Удалить';
	@override String get PinningScreen => 'Закрепить приложение на экране';
	@override String get SilentMode => 'Отключить звук';
	@override String get TimeOfAction => 'Время действия режима';
}

// Path: ForMatrix
class _TranslationsForMatrixRu implements TranslationsForMatrixEn {
	_TranslationsForMatrixRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get ImportantAndUrgent => 'Важно \nи срочно';
	@override String get ImportantAndNotUrgent => 'Важно, \nно не срочно';
	@override String get NotImportantAndUrgent => 'Не важно, \nно срочно';
	@override String get NotImportantAndNotUrgent => 'Не важно \nи не срочно';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'Calendar': return 'Календарь';
			case 'Tasks': return 'Задачи';
			case 'Events': return 'События';
			case 'NoTasks': return 'Пока нет запланированных задач';
			case 'NoEvents': return 'Пока нет запланированных событий';
			case 'NoTags': return 'Пока нет тегов';
			case 'Change': return 'Изменить';
			case 'Attention': return 'Внимание!';
			case 'SureDeleteTask': return 'Вы уверены, что хотите удалить задачу?';
			case 'SureDeleteEvent': return 'Вы уверены, что хотите удалить событие?';
			case 'SureDeleteTag': return 'Вы уверены, что хотите удалить тег?';
			case 'TasksContainTag': return 'Некоторые задачи содержат этот тег';
			case 'EventsContainTag': return 'Некоторые события содержат этот тег';
			case 'Yes': return 'Да';
			case 'No': return 'Нет';
			case 'Matrix': return 'Матрица Эйзенхауэре';
			case 'Menu': return 'Меню';
			case 'Main': return 'Главная';
			case 'Tags': return 'Мои теги';
			case 'RecurringTasks': return 'Повторяющиеся задачи';
			case 'PomodoroTimer': return 'PomodoroTimer';
			case 'Settings': return 'Настройки';
			case 'Work': return 'Работа';
			case 'Break': return 'Перерыв';
			case 'NoSuitableTasks': return 'Нет подходящих задач';
			case 'SelectTask': return 'Выбрать задачу';
			case 'RecurringTasksEvents': return 'Повторяющиеся задачи и события';
			case 'Parameters': return 'Параметры';
			case 'All': return 'Все';
			case 'Apply': return 'Применить';
			case 'SelectDate': return 'Выберите дату';
			case 'AddTime': return 'Добавить время';
			case 'Everyday': return 'Ежедневно';
			case 'EveryWeek': return 'Каждую @{number}-ю неделю:';
			case 'EveryMonth': return 'Ежемесячно @{date} числа';
			case 'Repeat': return 'Повторять';
			case 'AtStartTime': return 'На время начала';
			case 'DurationUpTo': return 'Длительность до';
			case 'Name': return 'Название';
			case 'Description': return 'Описание';
			case 'Today': return 'Сегодня';
			case 'Tag': return 'Тег';
			case 'RememberFor': return 'Напомнить за';
			case 'NumOfPomo': return 'Количество pomo';
			case 'DurationPomo': return 'Длительность pomo';
			case 'ShortBreak': return 'Маленький перерыв';
			case 'LongBreak': return 'Большой перерыв';
			case 'DoNotDisturb': return 'Не беспокоить';
			case 'Priority': return 'Приоритет';
			case 'Error': return 'Ошибка';
			case 'CanNotSaveTask': return 'Невозможно сохранить задачу!\nПроверьте заполненные данные.';
			case 'Ok': return 'ОK';
			case 'Reminder': return 'Напоминания';
			case 'Add': return 'Добавить';
			case 'SelectPriority': return 'Выберите приоритет';
			case 'ImportantAndUrgent': return 'Важно и срочно';
			case 'ImportantAndNotUrgent': return 'Важно, но не срочно';
			case 'NotImportantAndUrgent': return 'Не важно, но срочно';
			case 'NotImportantAndNotUrgent': return 'Не важно и не срочно';
			case 'ForMatrix.ImportantAndUrgent': return 'Важно \nи срочно';
			case 'ForMatrix.ImportantAndNotUrgent': return 'Важно, \nно не срочно';
			case 'ForMatrix.NotImportantAndUrgent': return 'Не важно, \nно срочно';
			case 'ForMatrix.NotImportantAndNotUrgent': return 'Не важно \nи не срочно';
			case 'Day': return 'День';
			case 'Week': return 'Неделя';
			case 'Month': return 'Месяц';
			case 'Duration': return 'Длительность';
			case 'Interval': return 'Интервал';
			case 'RepetitionDatePrecedesTaskDate': return 'Дата окончания повторения предшествует дате задачи';
			case 'Clear': return 'Понятно';
			case 'SelectDaysOfRepeatWeek': return 'Выберите дни недели повторения';
			case 'SelectInterval': return 'Выберите интервал';
			case 'SelectTime': return 'Выберите время';
			case 'SelectLanguage': return 'Выберите язык';
			case 'From': return 'От';
			case 'To': return 'До';
			case 'In': return 'За';
			case 'DayShortened': return 'д';
			case 'HoursShortened': return 'ч';
			case 'MinuteShortened': return 'мин';
			case 'Monday': return 'Пн';
			case 'Tuesday': return 'Вт';
			case 'Wednesday': return 'Ср';
			case 'Thursday': return 'Чт';
			case 'Friday': return 'Пт';
			case 'Saturday': return 'Сб';
			case 'Sunday': return 'Вс';
			case 'Save': return 'Сохранить';
			case 'Delete': return 'Удалить';
			case 'PinningScreen': return 'Закрепить приложение на экране';
			case 'SilentMode': return 'Отключить звук';
			case 'TimeOfAction': return 'Время действия режима';
			default: return null;
		}
	}
}

