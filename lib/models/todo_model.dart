class ToDoModel {
  ToDoModel({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.isDone,
    required this.dateTime,
    required this.urgentLevel,
  });

  String title;
  String description;
  int categoryId;
  bool isDone;
  String dateTime;
  int urgentLevel;
}
