import 'package:Notes/models/note.dart';
import 'package:Notes/services/database_services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNewNoteController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var notes = List<Note>();

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  void length() {
    // print(notes[6].content);
    print(notes.length);
  }

  bool isEmpty() {
    if (notes.length == 0)
      return true;
    else
      return false;
  }

  void addNoteToDatabase() async {
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      title: title,
      content: content,
      date: DateFormat("MMM dd, yyyy").format(DateTime.now()),
    );
    await DatabaseHelper.instance.addNote(note);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(
      id: id,
    );
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }

  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getNoteList();
    update();
  }
}
