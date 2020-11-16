import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../pages/note_detail_page.dart';
import '../controllers/add_new_note_controller.dart';

class SearchBar extends SearchDelegate {
  final AddNewNoteController controller = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? controller.notes
        : controller.notes.where((p) => p.content.contains(query)).toList();
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: StaggeredGridView.countBuilder(
        itemCount: suggestionList.length,
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
                    suggestionList[index].title,
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
                    suggestionList[index].content,
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
}
