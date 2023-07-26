const String categoryTable = 'cached_category';

class CachedCategoryFields {
  static final List<String> values = [
    id,
    categoryName,
    categoryColor,
    iconPath
  ];
  static const String id = "_id";
  static const String categoryName = "categoryName";
  static const String categoryColor = "categoryColor";
  static const String iconPath = "iconPath";
}

class CachedCategory {
  final int? id;
  final int categoryColor;
  final String categoryName;
  final int iconPath;

  CachedCategory({
    this.id,
    required this.iconPath,
    required this.categoryColor,
    required this.categoryName,
  });

  CachedCategory copyWith({
    int? id,
    int? categoryColor,
    String? categoryName,
    int? iconPath,
  }) =>
      CachedCategory(
        id: id ?? this.id,
        iconPath: iconPath ?? this.iconPath,
        categoryColor: categoryColor ?? this.categoryColor,
        categoryName: categoryName ?? this.categoryName,
      );

  static CachedCategory fromJson(Map<String, Object?> json) => CachedCategory(
        id: json[CachedCategoryFields.id] as int?,
        iconPath: json[CachedCategoryFields.iconPath] as int,
        categoryColor: json[CachedCategoryFields.categoryColor] as int,
        categoryName: json[CachedCategoryFields.categoryName] as String,
      );

  Map<String, Object?> toJson() => {
        CachedCategoryFields.id: id,
        CachedCategoryFields.categoryColor: categoryColor,
        CachedCategoryFields.iconPath: iconPath,
        CachedCategoryFields.categoryName: categoryName,
      };

  @override
  String toString() => '''
        ID: $id 
        CATEGORY NAME $categoryName
        CATEGORY COLOR $categoryColor
        ICON PATH $iconPath
      ''';
}
