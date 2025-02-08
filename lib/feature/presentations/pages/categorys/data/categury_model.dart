class Category {
  int id;
  String name;
  int? parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Category>? children;
  Category? parent;

  Category({
    required this.id,
    required this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.children,
    this.parent,
  });


  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      children: json['children'] != null
          ? (json['children'] as List)
              .map((child) => Category.fromJson(child))
              .toList()
          : null,
      parent: json['parent'] != null ? Category.fromJson(json['parent']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'children': children?.map((child) => child.toJson()).toList(),
      'parent': parent?.toJson(),
    };
  }
}
