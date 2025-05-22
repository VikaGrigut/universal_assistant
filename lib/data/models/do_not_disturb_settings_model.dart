import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/do_not_disturb_settings.dart';

class DoNotDisturbSettingsModel extends Equatable{
  const DoNotDisturbSettingsModel({
    required this.pinningScreen,
    required this.silentMode,
    required this.timeInterval

});

  final bool pinningScreen;

  final bool silentMode;

  final int timeInterval; // в минутах

  DoNotDisturbSettings toEntity() => DoNotDisturbSettings(
      pinningScreen: pinningScreen,
      silentMode: silentMode,
      timeInterval: timeInterval,
  );

  DoNotDisturbSettingsModel.fromEntity(DoNotDisturbSettings doNotDisturbEntity):this(pinningScreen: doNotDisturbEntity.pinningScreen,
      silentMode: doNotDisturbEntity.silentMode,
      timeInterval: doNotDisturbEntity.timeInterval,
  );

  DoNotDisturbSettingsModel.fromJson(Map<String, Object?> json)
    : pinningScreen = int.parse(json['pinningScreen'].toString()) == 0 ? false : true,
      timeInterval = int.parse(json['timeInterval'].toString()),
        silentMode = int.parse(json['silentMode'].toString()) == 0 ? false : true;

  Map<String, Object?> toJson() => {
        'timeInterval': timeInterval,
        'silentMode': silentMode == true ? 1 : 0,
        'pinningScreen': pinningScreen == true ? 1 : 0
    };

  @override
  List<Object?> get props => [
      pinningScreen,
      silentMode,
      timeInterval,
  ];
}