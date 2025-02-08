class Parent {
  String? name;
  int? id;
  int? parentId;
  String? createdAt;
  String? updatedAt;

  Parent({this.name, this.id, this.parentId, this.createdAt, this.updatedAt});

  Parent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
