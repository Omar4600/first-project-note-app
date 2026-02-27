import 'package:atfortyone_assi/controllers/note_controller.dart';
import 'package:atfortyone_assi/models/note_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteDetailsPage extends StatefulWidget {
  NoteModel note;
  NoteDetailsPage(this.note);

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

  NoteController noteController=Get.put(NoteController());

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    bool fav = noteController.isFavourite(widget.note);
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white,)
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (fav) {
                    noteController.removeFavourite(widget.note);
                  } else {
                    noteController.addFavourite(widget.note);
                  }
                });
              },
              child: fav
                  ? Icon(Icons.favorite, color: Colors.white)
                  : Icon(Icons.favorite_border, color: Colors.white),
            ),
          )
        ],
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.note.title, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
              Text(widget.note.date, style: TextStyle(fontSize: 10, color: Colors.grey,),),
              SizedBox(height: 10,),
              Text(widget.note.content, style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7),),),
            ],
          ),
        ),
      ),
    );
  }
}
