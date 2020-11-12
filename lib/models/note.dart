class Note {
  int id;
  String title;
  String content;
  String dateTimeEdited;
  String dateTimeCreated;

  Note({
    this.id,
    this.content,
    this.title,
    this.dateTimeEdited,
    this.dateTimeCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "dateTimeEdited": dateTimeEdited,
      "dateTimeCreated": dateTimeCreated,
    };
  }
}
