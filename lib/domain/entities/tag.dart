import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  const Tag({
    required this.id,
    required this.name,
});

  final int id;
  final String name;

  @override
  List<Object?> get props => [
      id,
      name,
  ];

}