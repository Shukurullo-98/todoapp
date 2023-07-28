import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/style.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({
    Key? key,
    required this.todo,
    required this.isDone,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  final CachedTodo todo;
  final VoidCallback onTap;
  final bool isDone;
  final VoidCallback onDelete;

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
                todo.todoTitle,
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
                todo.todoDescription,
                style: MyTextStyle.interRegular400
                    .copyWith(fontSize: 14, color: Colors.black45),
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: MyRepository.getSingleCategoryById(id: todo.categoryId),
            builder:
                (BuildContext context, AsyncSnapshot<CachedCategory> snapshot) {
              if (snapshot.hasData) {
                var category = snapshot.data!;
                return Row(
                  children: [
                    const Text("Category"),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(category.categoryName),
                    const Expanded(child: SizedBox()),
                    Icon(IconData(category.iconPath,
                        fontFamily: 'Inter-Medium')),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
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
            ),
          ),
          TextButton(
              onPressed: onDelete,
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
