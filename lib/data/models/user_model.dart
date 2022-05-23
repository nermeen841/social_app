class UserModel {
  String? name;
  String? image;
  String? email;
  String? uid;
  String? phone;
  String? bio;
  String? cover;
  bool? isEmailVerified;

  UserModel(
      {this.email,
      this.name,
      this.phone,
      this.uid,
      this.isEmailVerified,
      this.image,
      this.bio,
      this.cover});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    uid = json['uid'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['email_verified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'uid': uid,
      'email_verified': isEmailVerified,
      'bio': bio,
      'cover': cover
    };
  }
}
