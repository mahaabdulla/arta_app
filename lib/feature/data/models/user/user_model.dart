import 'dart:io';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? image;
  String? contactNumber;
  String? whatsappNumber;
  Null googleId;
  Null emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.image,
      this.contactNumber,
      this.whatsappNumber,
      this.googleId,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    contactNumber = json['contact_number'];
    whatsappNumber = json['whatsapp_number'];
    googleId = json['google_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['image'] = this.image;
    data['contact_number'] = this.contactNumber;
    data['whatsapp_number'] = this.whatsappNumber;
    data['google_id'] = this.googleId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
