import 'package:flutter/material.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/todo_list_screen.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todo_items.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  List<ToDoModel> myTodo = [];
  List<CategoryModel> categories = [];
  bool isDone = false;

  @override
  void initState() {
    myTodo = MyRepository.myTodo.where((element) => element.isDone).toList();
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            myTodo =
                MyRepository.myTodo.where((element) => element.isDone).toList();
          });
        },
        child: ListView(
          children: List.generate(
            myTodo.length,
            (index) {
              var todo = myTodo[index];
              var category = getCategory(categories, todo.categoryId);
              return ToDoItem(
                todo: todo,
                category: category,
                isDone: true,
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
