///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get Calendar => 'Calendar';
	String get Tasks => 'Tasks';
	String get Events => 'Events';
	String get NoTasks => 'There are no scheduled tasks yet';
	String get NoEvents => 'There are no scheduled events yet';
	String get NoTags => 'There are no tags yet';
	String get Change => 'Change';
	String get Attention => 'Attention!';
	String get SureDeleteTask => 'Are you sure you want to delete the task?';
	String get SureDeleteEvent => 'Are you sure you want to delete the event?';
	String get SureDeleteTag => 'Are you sure ypu want to delete the tag?';
	String get TasksContainTag => 'Some tasks contain this tag';
	String get EventsContainTag => 'Some events contain this tag';
	String get Yes => 'Yes';
	String get No => 'No';
	String get Matrix => 'The Eisenhower Matrix';
	String get Menu => 'Menu';
	String get Main => 'Main';
	String get Tags => 'My tags';
	String get RecurringTasks => 'Recurring tasks';
	String get PomodoroTimer => 'PomodoroTimer';
	String get Settings => 'Settings';
	String get Work => 'Work';
	String get Break => 'Break';
	String get NoSuitableTasks => 'There are no suitable tasks';
	String get SelectTask => 'Select a task';
	String get RecurringTasksEvents => 'Recurring tasks and events';
	String get Parameters => 'Parameters';
	String get All => 'All';
	String get Apply => 'Apply';
	String get SelectDate => 'Select a date';
	String get AddTime => 'Add time';
	String get Everyday => 'Everyday';
	String get EveryWeek => 'Every @{number} week:';
	String get EveryMonth => 'Monthly on the @{date}th';
	String get Repeat => 'Repeat';
	String get AtStartTime => 'At the start time';
	String get DurationUpTo => 'Duration up to';
	String get Name => 'Name';
	String get Description => 'Description';
	String get Today => 'Today';
	String get Tag => 'Tag';
	String get RememberFor => 'Remind for';
	String get NumOfPomo => 'Number of pomo';
	String get DurationPomo => 'Duration of pomo';
	String get ShortBreak => 'Short break';
	String get LongBreak => 'Long break';
	String get DoNotDisturb => 'Don\'t disturb';
	String get Priority => 'Priority';
	String get Error => 'Error';
	String get CanNotSaveTask => 'It is impossible to save the task!\nCheck the completed information.';
	String get Ok => 'ОK';
	String get Reminder => 'Reminder';
	String get Add => 'Add';
	String get SelectPriority => 'Select a priority';
	String get ImportantAndUrgent => 'Important and urgent';
	String get ImportantAndNotUrgent => 'Important, but not urgent';
	String get NotImportantAndUrgent => 'Not important, but urgent.';
	String get NotImportantAndNotUrgent => 'Not important and not urgent';
	late final TranslationsForMatrixEn ForMatrix = TranslationsForMatrixEn._(_root);
	String get Day => 'Day';
	String get Week => 'Week';
	String get Month => 'Month';
	String get Duration => 'Duration';
	String get Interval => 'Interval';
	String get RepetitionDatePrecedesTaskDate => 'The end date of the repetition precedes the task date.';
	String get Clear => 'Clear';
	String get SelectDaysOfRepeatWeek => 'Select the days of the repeat week';
	String get SelectInterval => 'Select an interval';
	String get SelectTime => 'Select a time';
	String get SelectLanguage => 'Select language';
	String get From => 'From';
	String get To => 'To';
	String get In => 'In';
	String get DayShortened => 'd';
	String get HoursShortened => 'h';
	String get MinuteShortened => 'm';
	String get Monday => 'Mon';
	String get Tuesday => 'Tue';
	String get Wednesday => 'Wed';
	String get Thursday => 'Thu';
	String get Friday => 'Fri';
	String get Saturday => 'Sat';
	String get Sunday => 'Sun';
	String get Save => 'Save';
	String get Delete => 'Delete';
	String get PinningScreen => 'Pin the app to the screen';
	String get SilentMode => 'Mute the sound';
	String get TimeOfAction => 'Duration of the mode';
}

// Path: ForMatrix
class TranslationsForMatrixEn {
	TranslationsForMatrixEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ImportantAndUrgent => 'Important \nand urgent';
	String get ImportantAndNotUrgent => 'Important, \nbut not urgent';
	String get NotImportantAndUrgent => 'Not important, \nbut urgent.';
	String get NotImportantAndNotUrgent => 'Not important \nand not urgent';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'Calendar': return 'Calendar';
			case 'Tasks': return 'Tasks';
			case 'Events': return 'Events';
			case 'NoTasks': return 'There are no scheduled tasks yet';
			case 'NoEvents': return 'There are no scheduled events yet';
			case 'NoTags': return 'There are no tags yet';
			case 'Change': return 'Change';
			case 'Attention': return 'Attention!';
			case 'SureDeleteTask': return 'Are you sure you want to delete the task?';
			case 'SureDeleteEvent': return 'Are you sure you want to delete the event?';
			case 'SureDeleteTag': return 'Are you sure ypu want to delete the tag?';
			case 'TasksContainTag': return 'Some tasks contain this tag';
			case 'EventsContainTag': return 'Some events contain this tag';
			case 'Yes': return 'Yes';
			case 'No': return 'No';
			case 'Matrix': return 'The Eisenhower Matrix';
			case 'Menu': return 'Menu';
			case 'Main': return 'Main';
			case 'Tags': return 'My tags';
			case 'RecurringTasks': return 'Recurring tasks';
			case 'PomodoroTimer': return 'PomodoroTimer';
			case 'Settings': return 'Settings';
			case 'Work': return 'Work';
			case 'Break': return 'Break';
			case 'NoSuitableTasks': return 'There are no suitable tasks';
			case 'SelectTask': return 'Select a task';
			case 'RecurringTasksEvents': return 'Recurring tasks and events';
			case 'Parameters': return 'Parameters';
			case 'All': return 'All';
			case 'Apply': return 'Apply';
			case 'SelectDate': return 'Select a date';
			case 'AddTime': return 'Add time';
			case 'Everyday': return 'Everyday';
			case 'EveryWeek': return 'Every @{number} week:';
			case 'EveryMonth': return 'Monthly on the @{date}th';
			case 'Repeat': return 'Repeat';
			case 'AtStartTime': return 'At the start time';
			case 'DurationUpTo': return 'Duration up to';
			case 'Name': return 'Name';
			case 'Description': return 'Description';
			case 'Today': return 'Today';
			case 'Tag': return 'Tag';
			case 'RememberFor': return 'Remind for';
			case 'NumOfPomo': return 'Number of pomo';
			case 'DurationPomo': return 'Duration of pomo';
			case 'ShortBreak': return 'Short break';
			case 'LongBreak': return 'Long break';
			case 'DoNotDisturb': return 'Don\'t disturb';
			case 'Priority': return 'Priority';
			case 'Error': return 'Error';
			case 'CanNotSaveTask': return 'It is impossible to save the task!\nCheck the completed information.';
			case 'Ok': return 'ОK';
			case 'Reminder': return 'Reminder';
			case 'Add': return 'Add';
			case 'SelectPriority': return 'Select a priority';
			case 'ImportantAndUrgent': return 'Important and urgent';
			case 'ImportantAndNotUrgent': return 'Important, but not urgent';
			case 'NotImportantAndUrgent': return 'Not important, but urgent.';
			case 'NotImportantAndNotUrgent': return 'Not important and not urgent';
			case 'ForMatrix.ImportantAndUrgent': return 'Important \nand urgent';
			case 'ForMatrix.ImportantAndNotUrgent': return 'Important, \nbut not urgent';
			case 'ForMatrix.NotImportantAndUrgent': return 'Not important, \nbut urgent.';
			case 'ForMatrix.NotImportantAndNotUrgent': return 'Not important \nand not urgent';
			case 'Day': return 'Day';
			case 'Week': return 'Week';
			case 'Month': return 'Month';
			case 'Duration': return 'Duration';
			case 'Interval': return 'Interval';
			case 'RepetitionDatePrecedesTaskDate': return 'The end date of the repetition precedes the task date.';
			case 'Clear': return 'Clear';
			case 'SelectDaysOfRepeatWeek': return 'Select the days of the repeat week';
			case 'SelectInterval': return 'Select an interval';
			case 'SelectTime': return 'Select a time';
			case 'SelectLanguage': return 'Select language';
			case 'From': return 'From';
			case 'To': return 'To';
			case 'In': return 'In';
			case 'DayShortened': return 'd';
			case 'HoursShortened': return 'h';
			case 'MinuteShortened': return 'm';
			case 'Monday': return 'Mon';
			case 'Tuesday': return 'Tue';
			case 'Wednesday': return 'Wed';
			case 'Thursday': return 'Thu';
			case 'Friday': return 'Fri';
			case 'Saturday': return 'Sat';
			case 'Sunday': return 'Sun';
			case 'Save': return 'Save';
			case 'Delete': return 'Delete';
			case 'PinningScreen': return 'Pin the app to the screen';
			case 'SilentMode': return 'Mute the sound';
			case 'TimeOfAction': return 'Duration of the mode';
			default: return null;
		}
	}
}

