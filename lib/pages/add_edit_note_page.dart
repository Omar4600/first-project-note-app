import 'package:atfortyone_assi/controllers/note_controller.dart';
import 'package:atfortyone_assi/models/note_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEditNotePage extends StatefulWidget {
  final NoteModel? note;
  final int? index;

  const AddEditNotePage({super.key, this.note, this.index});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {

  final NoteController noteController = Get.find();

  final TextEditingController _titleClt = TextEditingController();
  final TextEditingController _contentClt = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleClt.text = widget.note!.title;
      _contentClt.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Note" : "Add Note",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            /// 🔹 Scrollable Area
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleClt,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                        border: InputBorder.none, // line remove
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: _contentClt,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Details",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none, // line remove
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// 🔹 Fixed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onPressed: () {

                  if (_titleClt.text.isEmpty || _contentClt.text.isEmpty) return;

                  var inputFormat = DateFormat('dd/MM/yy HH:mm');
                  String date = inputFormat.format(DateTime.now());

                  if (widget.note != null) {
                    noteController.updateNote(
                      widget.index!,
                      NoteModel(_titleClt.text, _contentClt.text, date),
                    );
                  } else {
                    noteController.addNote(
                      NoteModel(_titleClt.text, _contentClt.text, date),
                    );
                  }

                  Get.back();
                },
                child: Text(
                  widget.note != null ? "Update Note" : "Add Note",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}