
import 'package:flutter/material.dart';
import 'package:my_todo_app/presentation/tabs/basket/basket_screen.dart';
import 'package:my_todo_app/presentation/tabs/done_list/done_list_screen.dart';
import 'package:my_todo_app/presentation/tabs/profile/profile_screen.dart';
import 'package:my_todo_app/presentation/tabs/todo_list/todo_list_screen.dart';



class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [
    const ToDoScreen(),
    const DoneScreen(),
    const BasketScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: [
          getItem(icon: Icons.add_task_outlined, labelText: "Todos"),
          getItem(icon: Icons.done_all, labelText: 'Done'),
          getItem(icon: Icons.delete, labelText: "Basket"),
          getItem(icon: Icons.perm_identity_rounded, labelText: "Profile"),
        ],
      ),
    );
  }
}

BottomNavigationBarItem getItem(
    {required IconData icon, required String labelText}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: labelText,
    activeIcon: Icon(
      icon,
      color: Colors.green,
    ),
  );
}
