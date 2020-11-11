import 'package:Notes/controllers/add_new_note_controller.dart';
import 'package:Notes/pages/add_new_note_page.dart';
import 'package:Notes/pages/note_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(AddNewNoteController());

  Widget emptyNotes() {
    return Container(
      child: Center(
        child: Text(
          "You don't have any Notes",
        ),
      ),
    );
  }

  Widget viewNotes() {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: controller.notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.25,
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                NoteDetailPage(),
                arguments: index,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.notes[index].title,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      controller.notes[index].content,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          Text("Are you sure you want to delete all notes?"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            controller.deleteAllNotes();
                            Get.back();
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
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: GetBuilder<AddNewNoteController>(
        builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewNotePage());
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
