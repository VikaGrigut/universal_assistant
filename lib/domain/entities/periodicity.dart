import 'package:equatable/equatable.dart';

import '../../core/enums/measuring_period.dart';

class Periodicity extends Equatable{
  const Periodicity({
    required this.periodLength,
    required this.measuringPeriod,
    this.endOfRepetition
});

  final int periodLength;
  final MeasuringPeriod measuringPeriod;
  final DateTime? endOfRepetition;

  @override
  List<Object?> get props => [
      periodLength,
      measuringPeriod,
      endOfRepetition
  ];

}