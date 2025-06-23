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
class TranslationsBe implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsBe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.be,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <be>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsBe _root = this; // ignore: unused_field

	@override 
	TranslationsBe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsBe(meta: meta ?? this.$meta);

	// Translations
	@override String get Calendar => 'Каляндар';
	@override String get Tasks => 'Задачы';
	@override String get Events => 'Падзеi';
	@override String get NoTasks => 'Пакуль няма запланаваных задач';
	@override String get NoEvents => 'Пакуль няма запланаваных падзей';
	@override String get NoTags => 'Пакуль няма тэгаў';
	@override String get Change => 'Змяніць';
	@override String get Attention => 'Увага!';
	@override String get SureDeleteTask => 'Вы ўпэўненыя, што хочаце выдаліць задачу?';
	@override String get SureDeleteEvent => 'Вы ўпэўненыя, што хочаце выдаліць падзею?';
	@override String get SureDeleteTag => 'Are you sure ypu want to delete the tag?';
	@override String get TasksContainTag => 'Some tasks contain this tag';
	@override String get EventsContainTag => 'Some events contain this tag';
	@override String get Yes => 'Да';
	@override String get No => 'Не';
	@override String get Matrix => 'Матрыца Эйзенхаўэра';
	@override String get Menu => 'Меню';
	@override String get Main => 'Галоўная ';
	@override String get Tags => 'Мае тэгі';
	@override String get RecurringTasks => 'Паўтараюцца задачы';
	@override String get PomodoroTimer => 'PomodoroTimer';
	@override String get Settings => 'Наладжваньне';
	@override String get Work => 'Праца';
	@override String get Break => 'Перапынак';
	@override String get NoSuitableTasks => 'Няма падыходных задач';
	@override String get SelectTask => 'Выбраць задачу';
	@override String get RecurringTasksEvents => 'Паўтараюцца задачы і падзеі';
	@override String get Parameters => 'Параметры';
	@override String get All => 'Усе';
	@override String get Apply => 'Прымяніць';
	@override String get SelectDate => 'Выберыце дату';
	@override String get AddTime => 'Дадаць час';
	@override String get Everyday => 'Штодня';
	@override String get EveryWeek => 'Кожную @{number}-ю тыдзень:';
	@override String get EveryMonth => 'Штомесяц @{date} колькасці';
	@override String get Repeat => 'Паўтараць';
	@override String get AtStartTime => 'На час пачатку';
	@override String get DurationUpTo => 'Працягласць да';
	@override String get Name => 'Назва';
	@override String get Description => 'Апісанне';
	@override String get Today => 'Сёння';
	@override String get Tag => 'Тэг';
	@override String get RememberFor => 'Нагадаць за';
	@override String get NumOfPomo => 'Колькасць pomo';
	@override String get DurationPomo => 'Працягласць pomo';
	@override String get ShortBreak => 'Маленькі перапынак';
	@override String get LongBreak => 'Вялікі перапынак';
	@override String get DoNotDisturb => 'Не турбаваць';
	@override String get Priority => 'Прыярытэт';
	@override String get Error => 'Памылка';
	@override String get CanNotSaveTask => 'Немагчыма захаваць задачу!\nПраверце запоўненыя дадзеныя.';
	@override String get Ok => 'ОK';
	@override String get Reminder => 'Напамін';
	@override String get Add => 'Дадаць';
	@override String get SelectPriority => 'Выберыце прыярытэт';
	@override String get ImportantAndUrgent => 'Важна і тэрмінова';
	@override String get ImportantAndNotUrgent => 'Важна, але не тэрмінова';
	@override String get NotImportantAndUrgent => 'Не важна, але тэрмінова';
	@override String get NotImportantAndNotUrgent => 'Не важна і не тэрмінова';
	@override late final _TranslationsForMatrixBe ForMatrix = _TranslationsForMatrixBe._(_root);
	@override String get Day => 'Дзень';
	@override String get Week => 'Тыдзень';
	@override String get Month => 'Месяц';
	@override String get Duration => 'Працягласць';
	@override String get Interval => 'Інтэрвал';
	@override String get RepetitionDatePrecedesTaskDate => 'Дата заканчэння паўтарэння папярэднічае даце задачы';
	@override String get Clear => 'Зразумела';
	@override String get SelectDaysOfRepeatWeek => 'Выберыце дні тыдня паўтарэння';
	@override String get SelectInterval => 'Выберыце інтэрвал';
	@override String get SelectTime => 'Выберыце час';
	@override String get SelectLanguage => 'Выберыце зыкя';
	@override String get From => 'Ад';
	@override String get To => 'Да';
	@override String get In => 'За';
	@override String get DayShortened => 'д';
	@override String get HoursShortened => 'ч';
	@override String get MinuteShortened => 'хв';
	@override String get Monday => 'Пн';
	@override String get Tuesday => 'Вт';
	@override String get Wednesday => 'Ср';
	@override String get Thursday => 'Чц';
	@override String get Friday => 'Пт';
	@override String get Saturday => 'Сб';
	@override String get Sunday => 'Нд';
	@override String get Save => 'Сохранить';
	@override String get Delete => 'Удалить';
	@override String get PinningScreen => 'Замацаваць дачыненне на экране';
	@override String get SilentMode => 'Адключыць гук';
	@override String get TimeOfAction => 'Час дзеяння рэжыму';
}

// Path: ForMatrix
class _TranslationsForMatrixBe implements TranslationsForMatrixEn {
	_TranslationsForMatrixBe._(this._root);

	final TranslationsBe _root; // ignore: unused_field

	// Translations
	@override String get ImportantAndUrgent => 'Важна \nі тэрмінова';
	@override String get ImportantAndNotUrgent => 'Важна, \nале не тэрмінова';
	@override String get NotImportantAndUrgent => 'Не важна, \nале тэрмінова';
	@override String get NotImportantAndNotUrgent => 'Не важна \nі не тэрмінова';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsBe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'Calendar': return 'Каляндар';
			case 'Tasks': return 'Задачы';
			case 'Events': return 'Падзеi';
			case 'NoTasks': return 'Пакуль няма запланаваных задач';
			case 'NoEvents': return 'Пакуль няма запланаваных падзей';
			case 'NoTags': return 'Пакуль няма тэгаў';
			case 'Change': return 'Змяніць';
			case 'Attention': return 'Увага!';
			case 'SureDeleteTask': return 'Вы ўпэўненыя, што хочаце выдаліць задачу?';
			case 'SureDeleteEvent': return 'Вы ўпэўненыя, што хочаце выдаліць падзею?';
			case 'SureDeleteTag': return 'Are you sure ypu want to delete the tag?';
			case 'TasksContainTag': return 'Some tasks contain this tag';
			case 'EventsContainTag': return 'Some events contain this tag';
			case 'Yes': return 'Да';
			case 'No': return 'Не';
			case 'Matrix': return 'Матрыца Эйзенхаўэра';
			case 'Menu': return 'Меню';
			case 'Main': return 'Галоўная ';
			case 'Tags': return 'Мае тэгі';
			case 'RecurringTasks': return 'Паўтараюцца задачы';
			case 'PomodoroTimer': return 'PomodoroTimer';
			case 'Settings': return 'Наладжваньне';
			case 'Work': return 'Праца';
			case 'Break': return 'Перапынак';
			case 'NoSuitableTasks': return 'Няма падыходных задач';
			case 'SelectTask': return 'Выбраць задачу';
			case 'RecurringTasksEvents': return 'Паўтараюцца задачы і падзеі';
			case 'Parameters': return 'Параметры';
			case 'All': return 'Усе';
			case 'Apply': return 'Прымяніць';
			case 'SelectDate': return 'Выберыце дату';
			case 'AddTime': return 'Дадаць час';
			case 'Everyday': return 'Штодня';
			case 'EveryWeek': return 'Кожную @{number}-ю тыдзень:';
			case 'EveryMonth': return 'Штомесяц @{date} колькасці';
			case 'Repeat': return 'Паўтараць';
			case 'AtStartTime': return 'На час пачатку';
			case 'DurationUpTo': return 'Працягласць да';
			case 'Name': return 'Назва';
			case 'Description': return 'Апісанне';
			case 'Today': return 'Сёння';
			case 'Tag': return 'Тэг';
			case 'RememberFor': return 'Нагадаць за';
			case 'NumOfPomo': return 'Колькасць pomo';
			case 'DurationPomo': return 'Працягласць pomo';
			case 'ShortBreak': return 'Маленькі перапынак';
			case 'LongBreak': return 'Вялікі перапынак';
			case 'DoNotDisturb': return 'Не турбаваць';
			case 'Priority': return 'Прыярытэт';
			case 'Error': return 'Памылка';
			case 'CanNotSaveTask': return 'Немагчыма захаваць задачу!\nПраверце запоўненыя дадзеныя.';
			case 'Ok': return 'ОK';
			case 'Reminder': return 'Напамін';
			case 'Add': return 'Дадаць';
			case 'SelectPriority': return 'Выберыце прыярытэт';
			case 'ImportantAndUrgent': return 'Важна і тэрмінова';
			case 'ImportantAndNotUrgent': return 'Важна, але не тэрмінова';
			case 'NotImportantAndUrgent': return 'Не важна, але тэрмінова';
			case 'NotImportantAndNotUrgent': return 'Не важна і не тэрмінова';
			case 'ForMatrix.ImportantAndUrgent': return 'Важна \nі тэрмінова';
			case 'ForMatrix.ImportantAndNotUrgent': return 'Важна, \nале не тэрмінова';
			case 'ForMatrix.NotImportantAndUrgent': return 'Не важна, \nале тэрмінова';
			case 'ForMatrix.NotImportantAndNotUrgent': return 'Не важна \nі не тэрмінова';
			case 'Day': return 'Дзень';
			case 'Week': return 'Тыдзень';
			case 'Month': return 'Месяц';
			case 'Duration': return 'Працягласць';
			case 'Interval': return 'Інтэрвал';
			case 'RepetitionDatePrecedesTaskDate': return 'Дата заканчэння паўтарэння папярэднічае даце задачы';
			case 'Clear': return 'Зразумела';
			case 'SelectDaysOfRepeatWeek': return 'Выберыце дні тыдня паўтарэння';
			case 'SelectInterval': return 'Выберыце інтэрвал';
			case 'SelectTime': return 'Выберыце час';
			case 'SelectLanguage': return 'Выберыце зыкя';
			case 'From': return 'Ад';
			case 'To': return 'Да';
			case 'In': return 'За';
			case 'DayShortened': return 'д';
			case 'HoursShortened': return 'ч';
			case 'MinuteShortened': return 'хв';
			case 'Monday': return 'Пн';
			case 'Tuesday': return 'Вт';
			case 'Wednesday': return 'Ср';
			case 'Thursday': return 'Чц';
			case 'Friday': return 'Пт';
			case 'Saturday': return 'Сб';
			case 'Sunday': return 'Нд';
			case 'Save': return 'Сохранить';
			case 'Delete': return 'Удалить';
			case 'PinningScreen': return 'Замацаваць дачыненне на экране';
			case 'SilentMode': return 'Адключыць гук';
			case 'TimeOfAction': return 'Час дзеяння рэжыму';
			default: return null;
		}
	}
}

