class ToDoModel {
  ToDoModel({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.isDone,
    required this.dateTime,
    required this.urgentLevel,
  });

  final String title;
  final String description;
  final int categoryId;
  final bool isDone;
  final String dateTime;
  final int urgentLevel;
}
