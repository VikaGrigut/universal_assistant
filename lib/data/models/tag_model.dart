import 'package:equatable/equatable.dart';
import 'package:universal_assistant/domain/entities/tag.dart';

class TagModel extends Equatable{
  const TagModel({
    required this.id,
    required this.name,
});

  final int id;

  final String name;

  TagModel.fromJson(Map<String, Object?> json)
  :id= int.parse(json['id'].toString()),
  name= json['name'].toString();

  Tag toEntity() => Tag(id: id, name: name);

  TagModel.fromEntity(Tag tagEntity):
      this(id: tagEntity.id, name: tagEntity.name);

  Map<String, Object?> toJsonForRep() => {
    //'id': id,
    'name': name,
  };

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
  };

  @override
  List<Object?> get props => [
      id,
      name,
  ];
}