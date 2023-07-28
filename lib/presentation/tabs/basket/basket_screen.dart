import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/presentation/tabs/basket/widgets/basket_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todo_items.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<CachedTodo> deletedToDo = [];
  List<CachedCategory> categories = [];
  bool isDone = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    deletedToDo = await MyRepository.getAllCachedTodosByDone(isDone: 2);
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
            deletedToDo.length,
            (index) {
              var todo = deletedToDo[index];

              return BasketItem(
                onUpdateTapped: () {},
                onDeleteTapped: () {
                  MyRepository.deleteCachedTodById(id: deletedToDo[index].id!);
                },
                cachedTodo: deletedToDo[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
