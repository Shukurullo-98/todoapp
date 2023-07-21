import 'package:flutter/material.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/style.dart';


class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.category,
      required this.isDone,
      required this.onTap})
      : super(key: key);

  final ToDoModel todo;
  final CategoryModel category;
  final VoidCallback onTap;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Category"),
              const SizedBox(
                width: 20,
              ),
              Text(category.categoryName),
              const Expanded(child: SizedBox()),
              Icon(category.iconPath),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Deadline:"),
              Text(todo.dateTime),
            ],
          ),
          TextButton(
              onPressed: onTap,
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Finished"),
                    Checkbox(value: isDone, onChanged: (v) {})
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
