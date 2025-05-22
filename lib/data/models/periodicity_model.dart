import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/periodicity.dart';

import '../../core/enums/measuring_period.dart';

class PeriodicityModel extends Equatable{
  const PeriodicityModel({
    required this.periodLength,
    required this.measuringPeriod,
    this.endOfRepetition
});

  final int periodLength;
  final MeasuringPeriod measuringPeriod;
  final DateTime? endOfRepetition;

  PeriodicityModel.fromJson(Map<String, Object?> json)
    :periodLength = int.parse(json['periodLength'].toString()),
    measuringPeriod = MeasuringPeriod.values[int.parse(json['measuringPeriod'].toString())],
    endOfRepetition = DateTime.parse(json['endOfRepetition'].toString());

  Periodicity toEntity() => Periodicity(
      periodLength: periodLength,
      measuringPeriod: measuringPeriod,
      endOfRepetition: endOfRepetition);

  PeriodicityModel.fromEntity(Periodicity periodicityEntity)
    :this(periodLength: periodicityEntity.periodLength,
      measuringPeriod: periodicityEntity.measuringPeriod,
      endOfRepetition: periodicityEntity.endOfRepetition);

  Map<String, Object?> toJson() => {
    'periodLength': periodLength,
    'measuringPeriod': measuringPeriod.index,
    'endOfRepetition': endOfRepetition
  };

  @override
  List<Object?> get props => [
      periodLength,
      measuringPeriod,
      endOfRepetition
  ];

}