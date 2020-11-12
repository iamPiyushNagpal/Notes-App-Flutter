class Note {
  int id;
  String title;
  String content;
  String dateTimeEdited;

  Note({
    this.id,
    this.content,
    this.title,
    this.dateTimeEdited,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "dateTimeEdited": dateTimeEdited,
    };
  }
}
