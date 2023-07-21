import 'package:flutter/material.dart';

class SelectUrgentLevel extends StatefulWidget {
  const SelectUrgentLevel({
    Key? key,
    required this.selectedStarsCount,
    required this.onChanged,
  }) : super(key: key);

  final int selectedStarsCount;
  final ValueChanged<int> onChanged;

  @override
  State<SelectUrgentLevel> createState() => _SelectUrgentLevelState();
}

class _SelectUrgentLevelState extends State<SelectUrgentLevel> {
  int count = 0;

  @override
  void initState() {
    count = widget.selectedStarsCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            count,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  count = index + 1;
                });
              },
              child: const Icon(
                Icons.star,
                size: 30,
                color: Colors.yellow,
              ),
            ),
          ),
          ...List.generate(
            5 - count,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  count = index + 1 + count;
                });
              },
              child: const Icon(
                Icons.star,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
