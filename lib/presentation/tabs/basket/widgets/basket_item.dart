import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/style.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    Key? key,
    required this.onUpdateTapped,
    required this.onDeleteTapped,
    required this.cachedTodo,
  }) : super(key: key);

  final VoidCallback onUpdateTapped;
  final VoidCallback onDeleteTapped;
  final CachedTodo cachedTodo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            offset: Offset(1, 3),
            blurRadius: 5,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cachedTodo.todoTitle,
                style: MyTextStyle.interSemiBold600.copyWith(
                  fontSize: 20,
                  color: MyColors.black,
                ),
              ),
              const Expanded(child: SizedBox()),
              ...List.generate(
                cachedTodo.urgentLevel,
                    (index) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ),
              ...List.generate(
                5 - cachedTodo.urgentLevel,
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
                    cachedTodo.todoDescription,
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
              TextButton(
                onPressed: onUpdateTapped,
                child: const Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Update"),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: onDeleteTapped,
                child: const Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Delete"),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
