import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo Screen"),
      ),
      body: Column(
        children: [
          const Text("Under development"),
          TextButton(
            onPressed: (){},
            child: const Text("Select image"),
          )
        ],
      ),
    );
  }
}
