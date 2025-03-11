// class Listing {
//   String? title;
//   String? price;
//   String? categoryId;
//   String? regionId;
//   String? status;
//   String? description;
//   int? userId;
//   String? primaryImage;
//   String? updatedAt;
//   String? createdAt;
//   int? id;

//   Listing({
//     this.title,
//     this.price,
//     this.categoryId,
//     this.regionId,
//     this.status,
//     this.description,
//     this.userId,
//     this.primaryImage,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//   });

//   Listing.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     price = json['price'];
//     categoryId = json['category_id'];
//     regionId = json['region_id'];
//     status = json['status'];
//     description = json['description'];
//     userId = json['user_id'];
//     primaryImage = json['primary_image'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'price': price,
//       'category_id': categoryId,
//       'region_id': regionId,
//       'status': status,
//       'description': description,
//       'user_id': userId,
//       'primary_image': primaryImage,
//       'updated_at': updatedAt,
//       'created_at': createdAt,
//       'id': id,
//     };
//   }
// }


class AdsModel {
  int? currentPage;
  List<dynamic>? data; // Use `dynamic` or a specific model class if the structure is known
  String? firstPageUrl;
  dynamic from; // Use `dynamic` or a specific type if the structure is known
  int? lastPage;
  String? lastPageUrl;
  List<AdsLinks>? links;
  dynamic nextPageUrl; // Use `dynamic` or a specific type if the structure is known
  String? path;
  int? perPage;
  dynamic prevPageUrl; // Use `dynamic` or a specific type if the structure is known
  dynamic to; // Use `dynamic` or a specific type if the structure is known
  int? total;

  AdsModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      currentPage: json['current_page'],
      data: json['data'] != null ? List<dynamic>.from(json['data']) : null,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] != null
          ? (json['links'] as List).map((v) => AdsLinks.fromJson(v)).toList()
          : null,
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class AdsLinks {
  String? url;
  String? label;
  bool? active;

  AdsLinks({this.url, this.label, this.active});

  factory AdsLinks.fromJson(Map<String, dynamic> json) {
    return AdsLinks(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}