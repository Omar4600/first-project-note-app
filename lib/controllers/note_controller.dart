import 'package:atfortyone_assi/models/note_models.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteController extends GetxController{

  final Box box=Hive.box('notes');
  final Box<NoteModel> boxFav = Hive.box<NoteModel>('favourites');
  List<NoteModel> notes=[];
  List<NoteModel> favourite=[];

  addNote(NoteModel note){
    box.add(note);
    update();
  }

  deleteNote(int index){
    box.deleteAt(index);
    update();
  }

  updateNote(int index, NoteModel note){
    box.putAt(index, note);
    update();
  }

  addFavourite(NoteModel note) {
    if (!isFavourite(note)) {
      boxFav.add(note);
    }
    update();
  }

  removeFavourite(NoteModel note) {
    final key = boxFav.keys.firstWhere(
          (k) => boxFav.get(k) == note,
      orElse: () => null,
    );
    if (key != null) {
      boxFav.delete(key);
    }
    update();
  }

  bool isFavourite(NoteModel note) {
    return boxFav.values.contains(note);
  }
}