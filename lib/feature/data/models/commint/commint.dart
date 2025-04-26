class CommintModel {
  String? content;
  String? listingId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  CommintModel(
      {this.content,
      this.listingId,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  CommintModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    listingId = json['listing_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['listing_id'] = this.listingId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }}