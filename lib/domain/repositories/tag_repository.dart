import 'package:universal_assistant/domain/entities/tag.dart';

abstract class TagRepository{
  Future<List<Tag>?> getAllTags();

  Future<bool> addTag(Tag tag);

  Future<bool> deleteTag(int tagId);

  Future<bool> saveTags(List<Tag> tags);
}