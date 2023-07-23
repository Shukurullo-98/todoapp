import 'package:flutter/material.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/models/todo_model.dart';

class MyRepository {
  static final MyRepository _instance = MyRepository._();

  factory MyRepository() {
    return _instance;
  }

  MyRepository._();

  static List<CategoryModel> categories = [
    CategoryModel(
        categoryId: 1,
        categoryName: "Work",
        iconPath: Icons.work_history,
        categoryColor: Colors.green),
    CategoryModel(
        categoryId: 2,
        categoryName: "Sport",
        iconPath: Icons.sports_kabaddi,
        categoryColor: Colors.amberAccent),
    CategoryModel(
        categoryId: 3,
        categoryName: "Health",
        iconPath: Icons.monitor_heart,
        categoryColor: Colors.deepOrangeAccent),
    CategoryModel(
        categoryId: 4,
        categoryName: "Food",
        iconPath: Icons.emoji_food_beverage_outlined,
        categoryColor: Colors.lime),
    CategoryModel(
        categoryId: 5,
        categoryName: "Coding",
        iconPath: Icons.code,
        categoryColor: Colors.blueGrey)
  ];
  static List<ToDoModel> myTodo = [
    ToDoModel(
        title: "Coding",
        description: "Coding",
        categoryId: 5,
        isDone: false,
        dateTime: "18/07/2023",
        urgentLevel: 3),
    ToDoModel(
        title: "Work",
        description: "Work",
        categoryId: 1,
        isDone: true,
        dateTime: "20/07/2023",
        urgentLevel: 4),
  ];

  static void addDoneTodo(int index) => myTodo[index].isDone = true;

  static void addNewTodo({required ToDoModel toDoModel}) =>
      myTodo.add(toDoModel);
}
