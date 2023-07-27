import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/db/cached_category.dart';
import 'package:my_todo_app/utils/colors.dart';
import 'package:my_todo_app/utils/style.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.onTap,
    required this.isSelected,
    required this.categoryModel,
  }) : super(key: key);
  final CachedCategory categoryModel;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 95,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(categoryModel.categoryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    IconData(categoryModel.iconPath, fontFamily: 'Inter-Medium'),
                    size: 34,
                    color: MyColors.white,
                  ),
                  Expanded(
                    child: Text(
                      categoryModel.categoryName,
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyle.interMedium500
                          .copyWith(fontSize: 15, color: MyColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isSelected,
            child: Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: 0,
              child: Container(
                color: MyColors.white.withOpacity(0.85),
                child: const Center(
                  child: Icon(Icons.check_circle_rounded,color: Colors.green,size: 34,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
