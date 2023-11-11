import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_app/models/post_model.dart';

class PostRepository extends GetxController {
  static PostRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<PostModel> getUserPostDetails(String email) async {
    final snapshot =
        await _db.collection("posts").where("Email", isEqualTo: email).get();
    final postUserData =
        snapshot.docs.map((e) => PostModel.fromSnapshot(e)).single;
    return postUserData;
  }

  Future<List<PostModel>> getAllPosts() async {
    final snapshot = await _db.collection("posts").get();
    final postData =
        snapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList();
    return postData;
  }

  deletePost(postId) async {
    final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    await postRef.delete();
  }

  Future<void> updatePost(PostModel updatedPost) async {
    final postRef = _db.collection('posts').doc(updatedPost.postId);
    await postRef.update({
      'postTitle': updatedPost.postTitle,
      'postDescrip': updatedPost.postDescrip,
      'Image': updatedPost.postImage,
    });
  }
}
