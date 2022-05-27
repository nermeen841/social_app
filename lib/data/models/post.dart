class PostModel {
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  String? uid;

  PostModel(
      {this.name,
      this.uid,
      this.image,
      this.dateTime,
      this.text,
      this.postImage});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
    image = json['image'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
      'image': image,
      'uid': uid,
    };
  }
}
