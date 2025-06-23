import 'package:sqflite/sqflite.dart';
import 'package:universal_assistant/data/models/tag_model.dart';
import 'package:universal_assistant/domain/entities/tag.dart';
import 'package:universal_assistant/domain/repositories/tag_repository.dart';

import '../datasources/locale_db.dart';

class TagRepositoryImpl implements TagRepository{
  final LocaleDBProvider dbProvider = LocaleDBProvider.dbProvider;

  @override
  Future<bool> addTag(Tag tag) async{
    final db = await dbProvider.db;
    TagModel tagModel = TagModel.fromEntity(tag);
    try {
      final result = await db.insert('Tags', tagModel.toJsonForRep());
      return result == 0 ? false : true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> deleteTag(int tagId) async{
    final db = await dbProvider.db;
    final result =
        await db.delete('Tags', where: 'id = ?', whereArgs: [tagId]);
    return result == 0 ? false : true;
  }

  @override
  Future<List<Tag>?> getAllTags() async{
    final db = await dbProvider.db;
    List<Map<String, Object?>> result = await db.query('Tags');
    List<Tag>? listTags;
    if (result.isEmpty) {
      return listTags;
    } else {
      List<TagModel> listModels = List<TagModel>.from(
          result.map((element) => TagModel.fromJson(element)));
      listTags = listModels.map((element) => element.toEntity()).toList();
      return listTags;
    }
  }

  @override
  Future<bool> saveTags(List<Tag> tags) async{
    final db = await dbProvider.db;

    await db.delete('Tags');

    final listModels = tags.map((tag) => TagModel.fromEntity(tag)).toList();

    final batch = db.batch();
    for (final model in listModels) {
      batch.insert(
        'Tags',
        model.toJsonForRep(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final result = await batch.commit();
    if(result.length == listModels.length){
      return true;
    }else{
      return false;
    }
  }

}