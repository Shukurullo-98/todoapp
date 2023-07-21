import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todo_items.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<ToDoModel> myTodo = [];
  List<CategoryModel> categories = [];
  bool isDone = false;

  @override
  void initState() {
    myTodo = MyRepository.myTodo.where((element) => !element.isDone).toList();
    categories = MyRepository.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo Screen"),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Center(
                                      child: Text("Cancel"),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    child: const Center(
                                      child: Text("Save"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView(
        children: List.generate(
          myTodo.length,
          (index) {
            var todo = myTodo[index];
            var category = getCategory(categories, todo.categoryId);
            return ToDoItem(
              todo: todo,
              category: category,
              isDone: false,
              onTap: () {
                isDone = true;
                setState(
                  () {
                    isDone = false;
                    myTodo.removeAt(index);
                    MyRepository.addDoneTodo(index);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

CategoryModel getCategory(List<CategoryModel> category, int categoryId) {
  return category
      .where((element) => element.categoryId == categoryId)
      .toList()[0];
}
