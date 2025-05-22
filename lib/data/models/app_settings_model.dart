import 'package:equatable/equatable.dart';
import '../../core/enums/languages.dart';
import '../../domain/entities/app_settings.dart';


class AppSettingsModel extends Equatable{
  const AppSettingsModel({
    required this.theme,
    required this.language
});

  final String theme;

  final Languages language;

  AppSettings toEntity() => AppSettings(theme: theme, language: language);

  AppSettingsModel.fromEntity(AppSettings appSettingsEntity)
    :this(theme: appSettingsEntity.theme, language: appSettingsEntity.language);

  Map<String, Object?> toJson() => {
      'theme': theme,
      'language': language.index
  };

  AppSettingsModel.fromJson(Map<String, Object?> json)
    : theme = json['theme'].toString(),
      language = Languages.values[int.parse(json['language'].toString())];


  @override
  List<Object?> get props => [
      theme,
      language,
  ];
}