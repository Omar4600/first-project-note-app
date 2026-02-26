import 'package:atfortyone_assi/controllers/note_controller.dart';
import 'package:atfortyone_assi/models/note_models.dart';
import 'package:atfortyone_assi/pages/favourite.dart';
import 'package:atfortyone_assi/pages/note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'add_edit_note_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {

  NoteController noteController=Get.put(NoteController());

  List<Widget> pages = [NotePage(),FavouritePage()];
  int selectedIndex=0;
  // TextEditingController _titleClt = TextEditingController();
  // TextEditingController _contentClt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Get.to(() => AddEditNotePage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: selectedIndex,
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.grey,
          onTap: (index){
            setState(() {
              selectedIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Note',),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite',),
          ]
      ),

      body: pages[selectedIndex],
    );
  }

  // _showDialog(){
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
  //                       noteController.addNote(
  //                         NoteModel(_titleClt.text, _contentClt.text, date)
  //                       );
  //                       Get.back();
  //                       setState(() {
  //                         selectedIndex = 0;
  //                       });
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
}
