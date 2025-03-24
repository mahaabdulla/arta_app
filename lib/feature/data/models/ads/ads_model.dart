import '../user/user_model.dart';

class ListingModel {
  final int? id;
  final String? title;
  final int? userId;
  final String? description;
  final String? price;
  final int? currencyId;
  final int? categoryId;
  final int? regionId;
  final String? status;
  final String? primaryImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;
  final CategoryModel? category;
  final RegionModel? region;
  final List<String>? images;
  final List<String>? comments;
  final CurrencyModel? currency;

  ListingModel({
    this.id,
    this.title,
    this.userId,
    this.description,
    this.price,
    this.currencyId,
    this.categoryId,
    this.regionId,
    this.status,
    this.primaryImage,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.category,
    this.region,
    this.images,
    this.comments,
    this.currency,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      userId: json['user_id'] as int?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      currencyId: json['currency_id'] as int?,
      categoryId: json['category_id'] as int?,
      regionId: json['region_id'] as int?,
      status: json['status'] as String?,
      primaryImage: json['primary_image'] as String?,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
      region: json['region'] != null ? RegionModel.fromJson(json['region']) : null,
      images: (json['images'] as List?)?.map((e) => e as String).toList() ?? [],
      comments: (json['comments'] as List?)?.map((e) => e as String).toList() ?? [],
      currency: json['currency'] != null ? CurrencyModel.fromJson(json['currency']) : null,
    );
  }
}

// class UserModel {
//   final int? id;
//   final String? name;

//   UserModel({this.id, this.name});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//     );
//   }
// }

class CategoryModel {
  final int? id;
  final String? name;

  CategoryModel({this.id, this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class RegionModel {
  final int? id;
  final String? name;

  RegionModel({this.id, this.name});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class CurrencyModel {
  final int? id;
  final String? code;
  final String? name;
  final String? abbr;

  CurrencyModel({this.id, this.code, this.name, this.abbr});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      abbr: json['abbr'] as String?,
    );
  }
}
