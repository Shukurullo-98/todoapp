import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todo_items.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  List<CachedTodo> myTodo = [];
  List<CachedCategory> categories = [];
  bool isDone = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    myTodo = await MyRepository.getAllCachedTodosByDone(isDone: 1);
    categories = await MyRepository.getAllCachedCategories();
    setState(() {});
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
            _init();
          });
        },
        child: ListView(
          children: List.generate(
            myTodo.length,
            (index) {
              var todo = myTodo[index];

              return ToDoItem(
                todo: todo,
                isDone: true,
                onTap: () {},
                onDelete: () {
                  MyRepository.updateCachedTodoIsDone(id: myTodo[index].id!, isDone: 2);
                  _init();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
