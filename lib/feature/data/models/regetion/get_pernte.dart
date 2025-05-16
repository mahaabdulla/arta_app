class RegetionParent {
  int? id;
  String? name;
  int? parentId;

  RegetionParent(
      {this.id, this.name, this.parentId,});

  RegetionParent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    return data;
  }
}