import 'package:flutter/material.dart';
import 'package:my_todo_app/utils/colors.dart';

class ModalTopView extends StatelessWidget {
  const ModalTopView({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: MyColors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              Expanded(
                child: Center(
                  child: Material(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(onPressed: onTap, child: const Text("Close", style: TextStyle(fontSize: 17,
                fontWeight: FontWeight.w400,color: Color(0xFF007AFF)),))
            ],
          )
        ],
      ),
    );
  }
}
