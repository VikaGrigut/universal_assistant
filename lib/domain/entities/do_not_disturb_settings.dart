import 'package:equatable/equatable.dart';

class DoNotDisturbSettings extends Equatable{
  const DoNotDisturbSettings({
    required this.pinningScreen,
    required this.silentMode,
    required this.timeInterval

});

  final bool pinningScreen;
  final bool silentMode;
  final int timeInterval; // в минутах либо пока работает помодоро

  @override
  List<Object?> get props => [
      pinningScreen,
      silentMode,
      timeInterval
  ];

}