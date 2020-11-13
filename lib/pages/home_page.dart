import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../controllers/add_new_note_controller.dart';
import '../pages/add_new_note_page.dart';
import '../pages/note_detail_page.dart';

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
      padding: EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: StaggeredGridView.countBuilder(
        itemCount: controller.notes.length,
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
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
                mainAxisSize: MainAxisSize.min,
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
                  Text(
                    controller.notes[index].content,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.notes[index].dateTimeEdited,
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
