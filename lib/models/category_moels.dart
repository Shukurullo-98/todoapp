import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.iconPath,
    required this.categoryColor,
  });

  final int categoryId;
  final String categoryName;
  final IconData iconPath;
  final Color categoryColor;
}
