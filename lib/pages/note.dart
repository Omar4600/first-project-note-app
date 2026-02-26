import 'package:atfortyone_assi/controllers/note_controller.dart';
import 'package:atfortyone_assi/models/note_models.dart';
import 'package:atfortyone_assi/pages/note_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'add_edit_note_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

  NoteController noteController=Get.put(NoteController());
  // TextEditingController _titleClt = TextEditingController();
  // TextEditingController _contentClt = TextEditingController();

  final Box box=Hive.box('notes');

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Notes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: GetBuilder<NoteController>(
        //init: NoteController(),  ///Local initiate.
        builder: (_) {      //noteController; variable name instead of _ for local initiate.
          return box.keys.length==0 ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sticky_note_2_outlined,
                  size: 60,
                  color: Colors.grey,
                ),
                SizedBox(height: 8),
                Text(
                  "No notes yet",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          )
          : ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, box, child) {
              return ListView.builder(
                itemCount: box.keys.length,
                itemBuilder: (context, index) {
                  // Reverse index
                  final reverseIndex = box.keys.length - 1 - index;
                  final NoteModel note = box.getAt(reverseIndex);

                  return ListTile(
                    onTap: () {
                      Get.to(NoteDetailsPage(note));
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          note.title.length > 20
                              ? note.title.substring(0, 15) + "..."
                              : note.title,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          DateFormat('dd/MM/yy').format(
                            DateFormat('dd/MM/yy HH:mm').parse(note.date),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => AddEditNotePage(
                                note: note,
                                index: reverseIndex,
                              ));
                            },
                            child: Icon(Icons.edit, color: Colors.deepPurpleAccent),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _deleteDialog(reverseIndex);
                            },
                            child: Icon(Icons.delete, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
              ;
            }
          );
        }
      ),
    );
  }

  // _showDialog(int index){
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context){
  //         return Center(
  //           child: SingleChildScrollView(
  //             child: AlertDialog(
  //               content: Column(
  //                 children: [
  //                   TextField(
  //                     controller: _titleClt,
  //                     showCursor: true, // ensures the cursor is visible
  //                     cursorColor: Colors.blue, // change cursor color if you want
  //                     cursorWidth: 2,
  //                     decoration: InputDecoration(
  //                       hintText: 'Title',
  //                       hintStyle: TextStyle(color: Colors.grey),
  //                     ),
  //                   ),
  //
  //                   TextField(
  //                     controller: _contentClt,
  //                     showCursor: true, // ensures the cursor is visible
  //                     cursorColor: Colors.blue, // change cursor color if you want
  //                     cursorWidth: 2,
  //                     decoration: InputDecoration(
  //                       hintText: 'Details',
  //                       hintStyle: TextStyle(color: Colors.grey),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               actions: [
  //                 InkWell(
  //                   onTap: (){
  //                     Get.back();
  //                   },
  //                   child: CircleAvatar(
  //                     child: Icon(Icons.close, color: Colors.redAccent,),
  //                     backgroundColor: Colors.grey[50],
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: (){
  //
  //                     if(_titleClt.text.isNotEmpty && _contentClt.text.isNotEmpty){
  //
  //                       var inputFormat = DateFormat('dd/MM/yy HH:mm');
  //                       String date = inputFormat.format(DateTime.now());
  //
  //                       noteController.updateNote(
  //                         index,
  //                           NoteModel(_titleClt.text, _contentClt.text, date)
  //                       );
  //                       Get.back();
  //                     }
  //
  //                   },
  //                   child: CircleAvatar(
  //                     child: Icon(Icons.check, color: Colors.greenAccent,),
  //                     backgroundColor: Colors.grey[50],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }

  _deleteDialog(int index){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                content: Column(
                  children: [
                    Text('Are you sure?',style: TextStyle(fontSize: 20),)
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close, color: Colors.redAccent,),
                      backgroundColor: Colors.grey[50],
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      noteController.deleteNote(index);
                      Get.back();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.check, color: Colors.greenAccent,),
                      backgroundColor: Colors.grey[50],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
