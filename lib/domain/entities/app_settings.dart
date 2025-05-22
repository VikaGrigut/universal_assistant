import 'package:equatable/equatable.dart';

import '../../core/enums/languages.dart';

class AppSettings extends Equatable{
  const AppSettings({
    required this.theme,
    required this.language
});

  final String theme;
  final Languages language;

  @override
  List<Object?> get props => [
      theme,
      language
  ];

}