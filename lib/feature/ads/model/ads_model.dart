class Listing {
  String? title;
  String? price;
  String? categoryId;
  String? regionId;
  String? status;
  String? description;
  int? userId;
  String? primaryImage;
  String? updatedAt;
  String? createdAt;
  int? id;

  Listing({
    this.title,
    this.price,
    this.categoryId,
    this.regionId,
    this.status,
    this.description,
    this.userId,
    this.primaryImage,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Listing.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    categoryId = json['category_id'];
    regionId = json['region_id'];
    status = json['status'];
    description = json['description'];
    userId = json['user_id'];
    primaryImage = json['primary_image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'category_id': categoryId,
      'region_id': regionId,
      'status': status,
      'description': description,
      'user_id': userId,
      'primary_image': primaryImage,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
