import 'package:flutter/material.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    Key? key,
    required this.onUpdateTapped,
    required this.onDeleteTapped,
  }) : super(key: key);

  final VoidCallback onUpdateTapped;
  final VoidCallback onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            offset: Offset(1, 3),
            blurRadius: 5,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: onUpdateTapped,
                child: const Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Update"),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: onDeleteTapped,
                child: const Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Delete"),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
