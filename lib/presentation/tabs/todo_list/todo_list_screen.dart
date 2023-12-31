import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_todo_app/category_add_screen/category_add_screen.dart';
import 'package:my_todo_app/data/global_widgets/my_custom_widgets.dart';
import 'package:my_todo_app/data/global_widgets/profile_image_appbar.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/local_data/db/cached_todo.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/models/category_moels.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/category_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/modal_top_view.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/select_date_item.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/select_urgent_level.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/widgets/todo_items.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/style.dart';
import 'package:my_todo_app/utils/utility_functions.dart';
import 'dart:io';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<CachedTodo> myTodo = [];
  List<CachedCategory> categories = [];
  bool isDone = false;
  int categorySelected = -1;
  int urgentLevel = 0;

  DateTime selectedData = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<DateTime> _selectData(BuildContext context) async {
    final selected = await showDatePicker(
        context: context,
        initialDate: selectedData,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030));
    if (selected != null && selected != selectedData) {
      setState(() {
        selectedData = selected;
      });
    }
    return selectedData;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    myTodo = await MyRepository.getAllCachedTodosByDone(isDone: 0);
    categories = await MyRepository.getAllCachedCategories();
    setState(() {});
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
        backgroundColor: Colors.blue,
        title: const Text("ToDo Screen"),
        leading: const ProfileImageAppBar(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CategoryAddScreen(
                      onCategoryAddedListener: (value) {
                        if(value){
                          _init();
                        }
                      },
                    );
                  },
                ),
              );
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return Dialog(
              //       insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              //       child: Container(
              //         padding: EdgeInsets.all(16),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(16),
              //         ),
              //         height: 350,
              //         width: double.infinity,
              //         child: Column(children: [
              //           TextField(),
              //           Container(height: 100,child: ListView(),)
              //         ],),
              //       ),
              //     );
              //   },
              // );
            },
            child: Text(
              "Add category",
              style: MyTextStyle.interBold700.copyWith(color: MyColors.white),
            ),
          ),
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
                    child: StatefulBuilder(
                        builder: (BuildContext context, setState) {
                      return Scaffold(
                        resizeToAvoidBottomInset: false,
                        body: Container(
                          margin: const EdgeInsets.all(16),
                          child: Column(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      isSelected: categorySelected == index,
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
                                height: 20,
                              ),
                              SelectUrgentLevel(
                                  selectedStarsCount: urgentLevel,
                                  onChanged: (v) {
                                    urgentLevel = v;
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              SelectDateItem(
                                text: DateFormat('dd.MM.yyyy')
                                    .format(selectedData),
                                onTap: () async {
                                  var t = await _selectData(context);
                                  setState(
                                    () {
                                      selectedData = t;
                                    },
                                  );
                                },
                              ),
                              SelectDateItem(
                                text:
                                    "${selectedTime.hour}:${selectedTime.minute}",
                                onTap: () async {
                                  var t = await _selectTime(context);
                                  setState(() {
                                    selectedTime = t;
                                  });
                                },
                              ),
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
                                      onTap: () async {
                                        String titleText = titleController.text;
                                        String descriptionText =
                                            descriptionController.text;
                                        if (titleText.length < 3) {
                                          UtilityFunctions.getMyToast(
                                              message: "Sarlavxani kiriting!");
                                        } else if (descriptionText.length < 5) {
                                          UtilityFunctions.getMyToast(
                                              message: "Izox kiriting!");
                                        } else if (categorySelected < 0) {
                                          UtilityFunctions.getMyToast(
                                              message: "Kategoryani tanlang!");
                                        } else if (urgentLevel == 0) {
                                          UtilityFunctions.getMyToast(
                                              message:
                                                  "Muhimlilik darajasini tanlang!");
                                        } else {
                                          var dateTime = DateTime(
                                            selectedData.year,
                                            selectedData.month,
                                            selectedData.day,
                                            selectedTime.hour,
                                            selectedTime.minute,
                                          );

                                          // ToDoModel toDoModel = ToDoModel(
                                          //     title: titleText,
                                          //     description: descriptionText,
                                          //     categoryId:
                                          //         categories[categorySelected]
                                          //             .categoryId,
                                          //     isDone: false,
                                          //     dateTime: dateTime.toString(),
                                          //     urgentLevel: urgentLevel);
                                          CachedTodo cachedTodo = CachedTodo(
                                            dateTime: dateTime.toString(),
                                            todoTitle: titleText,
                                            categoryId:
                                                categories[categorySelected]
                                                    .id!,
                                            urgentLevel: urgentLevel,
                                            isDone: 0,
                                            todoDescription: descriptionText,
                                          );
                                          await MyRepository.insertCachedTodo(
                                              cachedTodo: cachedTodo);
                                          _init();
                                          setDefaults();
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
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
            return ToDoItem(
              todo: todo,
              isDone: isDone,
              onTap: () {
                setState(
                  () {
                    myTodo.removeAt(index);
                    MyRepository.updateCachedTodoIsDone(
                        id: todo.id!, isDone: 1);
                  },
                );
              },
              onDelete: () {
                MyRepository.updateCachedTodoIsDone(
                  isDone: 2,
                  id: myTodo[index].id!,
                );
                _init();
              },
            );
          },
        ),
      ),
    );
  }

  void setDefaults() {
    urgentLevel = 0;
    descriptionController.clear();
    titleController.clear();
    categorySelected = -1;
  }
}

CategoryModel getCategory(List<CategoryModel> category, int categoryId) {
  return category
      .where((element) => element.categoryId == categoryId)
      .toList()[0];
}
