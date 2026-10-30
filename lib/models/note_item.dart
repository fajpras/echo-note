class NoteItem {
  final String id;
  String title;
  String content;
  String category;
  String date;
  bool isPinned;

  NoteItem({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
    this.isPinned = false,
  });
}
