import 'package:flutter/material.dart';
import 'package:my_todo_app/data/global_widgets/profile_image_appbar.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/presentation/tabs/basket/widgets/basket_item.dart';

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
        backgroundColor: Colors.blue,
        title: const Text("Basket Screen"),
        leading: const ProfileImageAppBar(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Rostdan xam barchasini o'chirmoqchimisiz"),
                    actions: [
                      TextButton(
                        onPressed: () {Navigator.pop(context);},
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          MyRepository.clearAllCachedTodos();
                          _init();
                           Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
          ),
        ],
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
              return BasketItem(
                onUpdateTapped: () {},
                onDeleteTapped: () {showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Rostdan xam o'chirmoqchimisiz"),
                      actions: [
                        TextButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            MyRepository.deleteCachedTodById(id: deletedToDo[index].id!);
                            _init();
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );

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
