import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/style.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<ToDoModel> myTodo = [];
  List<CategoryModel> categories = [];

  @override
  void initState() {
    myTodo = MyRepository.myTodo;
    categories = MyRepository.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ToDo Screen"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        body: ListView(
          children: List.generate(
            myTodo.length,
            (index) {
              var todo = myTodo[index];
              var category = getCategory(categories, todo.categoryId);
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: const Offset(1, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          todo.title,
                          style: MyTextStyle.interSemiBold600.copyWith(
                            fontSize: 20,
                            color: MyColors.black,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        ...List.generate(
                          todo.urgentLevel,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                        ...List.generate(
                          5 - todo.urgentLevel,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          todo.description,
                          style: MyTextStyle.interRegular400
                              .copyWith(fontSize: 14, color: Colors.black45),
                        ))
                      ],
                    ),
                    const Row(
                      children: [Text("Category: ")],
                    ),
                    Row(
                      children: [
                        const Text("Category"),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Icon(category.iconPath),
                            Text(category.categoryName),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Deadline:"),
                        Text(todo.dateTime),
                      ],
                    ),

                  ],
                ),
              );
            },
          ),
        ));
  }
}

CategoryModel getCategory(List<CategoryModel> category, int categoryId) {
  return category
      .where((element) => element.categoryId == categoryId)
      .toList()[0];
}
