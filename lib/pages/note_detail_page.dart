import 'package:Notes/controllers/add_new_note_controller.dart';
import 'package:Notes/pages/edit_note_page.dart';
import 'package:Notes/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteDetailPage extends StatelessWidget {
  final AddNewNoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              Get.to(
                EditNotePage(),
                arguments: i,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  child: Column(
                    children: [
                      FlatButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete the note?"),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      controller
                                          .deleteNote(controller.notes[i].id);
                                      Get.offAll(HomePage());
                                    },
                                    child: Text("Yes"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.delete,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
              );
            },
          ),
        ],
      ),
      body: GetBuilder<AddNewNoteController>(
        builder: (_) => Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  controller.notes[i].title,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  controller.notes[i].date,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  controller.notes[i].content,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
