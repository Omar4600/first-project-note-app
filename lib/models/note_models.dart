import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'note_models.g.dart';

@HiveType(typeId: 0)
class NoteModel{
  @HiveField(0)
  String title='';

  @HiveField(1)
  String content='';

  @HiveField(2)
  String date='';

  NoteModel(this.title, this.content, this.date);
}