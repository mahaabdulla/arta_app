class Category {
  int? id;
  String? name;
  int? parentId;
  String? image;
  Null? createdAt;
  Null? updatedAt;
  List<Children>? children;
  Parent? parent;

  Category(
      {this.id,
      this.name,
      this.parentId,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.children,
      this.parent});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  int? parentId;
  Null? image;
  Null? createdAt;
  Null? updatedAt;

  Children(
      {this.id,
      this.name,
      this.parentId,
      this.image,
      this.createdAt,
      this.updatedAt});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Parent {
  int? id;
  String? name;
  int? parentId;
  String? image;
  Null? createdAt;
  Null? updatedAt;

  Parent(
      {this.id,
      this.name,
      this.parentId,
      this.image,
      this.createdAt,
      this.updatedAt});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
