import 'package:atfortyone_assi/controllers/note_controller.dart';
import 'package:atfortyone_assi/models/note_models.dart';
import 'package:atfortyone_assi/pages/note_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

NoteController noteController = Get.put(NoteController());
final Box<NoteModel> boxFav = Hive.box<NoteModel>('favourites');

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GetBuilder<NoteController>(builder: (_) {
        return boxFav.keys.length == 0
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'No favourite note added',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          ),
        ) : ValueListenableBuilder(
            valueListenable: boxFav.listenable(),
            builder: (context, boxFav, child) {
              return ListView.builder(
                itemCount: boxFav.keys.length,
                itemBuilder: (context, index) {

                  final reverseIndex = boxFav.keys.length - 1 - index;
                  final NoteModel fav = boxFav.getAt(reverseIndex)!;

                  return ListTile(
                    onTap: () {
                      Get.to(NoteDetailsPage(fav));
                    },
                    title: Text(
                      fav.title.length > 20
                          ? fav.title.substring(0, 15) + "..."
                          : fav.title,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      fav.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: InkWell(
                      onTap: () {
                        noteController.removeFavourite(fav);
                      },
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  );
                },
              );
            });
      }),
    );
  }
}
