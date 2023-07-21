import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_todo_app/data/global_widgets/my_custom_widgets.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/category_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/modal_top_view.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/select_urgent_level.dart';
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
  int categorySelected = 0;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    myTodo = MyRepository.myTodo.where((element) => !element.isDone).toList();
    categories = MyRepository.categories;
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
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
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Scaffold(
                        body: Column(
                          children: [
                            ModalTopView(
                                text: "Create new ToDo",
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextField(
                                controller: titleController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextField(
                                controller: descriptionController,
                                maxLines: 5,
                                maxLength: 150,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Description here',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(8),
                                    fillColor: const Color(0xFFD7D7D7)),
                              ),
                            ),
                            SizedBox(
                              height: 95,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (BuildContext context, index) {
                                  return CategoryItem(
                                    isSelected: false,
                                    categoryModel: categories[index],
                                    onTap: () {
                                      setState(() {
                                        categorySelected = index;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SelectUrgentLevel(
                                selectedStarsCount: 0, onChanged: (v) {}),
                            const Expanded(child: SizedBox()),
                            Row(
                              children: [
                                Expanded(
                                  child: MyCustomButton(
                                    buttonText: 'Cancel',
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: MyCustomButton(
                                    buttonText: 'Save',
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
