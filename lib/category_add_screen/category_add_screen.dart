import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/data/repository.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({Key? key, required this.onCategoryAddedListener}) : super(key: key);

  final ValueChanged<bool> onCategoryAddedListener;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  List<IconData> icons = [];
  int iconCodePoint = 0;
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _init() {
    icons.add(Icons.sports_kabaddi);
    icons.add(Icons.work);
    icons.add(Icons.access_alarm);
    icons.add(Icons.book);
    icons.add(Icons.abc_rounded);
    icons.add(Icons.add_call);
    icons.add(Icons.account_balance);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: textController,
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  icons.length,
                  (index) => GestureDetector(
                    onTap: () {
                      iconCodePoint = icons[index].codePoint;
                    },
                    child: Icon(
                      icons[index],
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                String categoryName = textController.text;
                if (categoryName.isEmpty) {
                  UtilityFunctions.getMyToast(
                      message: "Categorya nomini kiriting");
                } else if (iconCodePoint == 0) {
                  UtilityFunctions.getMyToast(message: "Ikonka tanlang");
                } else {
                  var cacheCategory = CachedCategory(
                    iconPath: iconCodePoint,
                    categoryColor: Colors.blue.value,
                    categoryName: categoryName,
                  );
                  var t = await MyRepository.insertCachedCategory(
                      cachedCategory: cacheCategory);
                  if (t.id != null) {
                    UtilityFunctions.getMyToast(
                        message: "Kategorya muvaffaqiyatli qo'shildi!");

                      widget.onCategoryAddedListener.call(true);

                  }
                }
              },
              child: const Row(
                children: [
                  Text("Add category"),
                  SizedBox(
                    width: 14,
                  ),
                  Icon(
                    Icons.category,
                    size: 40,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
