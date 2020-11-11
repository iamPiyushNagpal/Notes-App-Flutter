class Note {
  int id;
  String title;
  String content;
  String date;

  Note({
    this.id,
    this.content,
    this.title,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "date": date,
    };
  }
}
