import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String postTitle;
  final String postDescrip;
  final String postImage;

  PostModel(
      {required this.postId,
      required this.postTitle,
      required this.postDescrip,
      required this.postImage});

  toJson() {
    return {
      "postId": postId,
      "postTitle": postTitle,
      "postDescrip": postDescrip,
      "imageUrl": postImage
    };
  }

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return PostModel(
        postId: data?["postId"],
        postTitle: data?["postTitle"],
        postDescrip: data?["postDescrip"],
        postImage: data?["imageUrl"]);
  }
}
