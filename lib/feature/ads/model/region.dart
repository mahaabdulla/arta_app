import 'package:arta_app/feature/ads/model/region_children_model.dart';
import 'package:arta_app/feature/ads/model/region_parent_model.dart';

class Region {
  int? id;
  String? name;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  List<Children>? children;
  Parent? parent;

  Region(
      {this.id,
      this.name,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.children,
      this.parent});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
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


