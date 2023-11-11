import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/models/post_model.dart';
import 'package:new_app/pages/update_post.dart';
import 'package:new_app/repository/post_repository.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostViewScreen extends StatefulWidget {
  static String id = 'postViewScreen';

  const PostViewScreen({Key? key}) : super(key: key);

  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  final repo = Get.put(PostRepository());

  Future<void> _refreshPosts() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(PostViewScreen.id),
      onVisibilityChanged: (VisibilityInfo info) {
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Posts'),
          leading: const Icon(Icons.arrow_back_ios_new),
        ),
        body: Center(
          child: FutureBuilder<List<PostModel>>(
            future: repo.getAllPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: _refreshPosts,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => (Column(
                        children: [
                          ListTile(
                            iconColor: Colors.blue,
                            tileColor: Colors.blue.withOpacity(0.1),
                            leading:
                                Image.network(snapshot.data![index].postImage),
                            title: Text((snapshot.data![index].postTitle)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].postDescrip)
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    tooltip: 'Update',
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: UpdatePostScreen(
                                          post: PostModel(
                                              postId:
                                                  snapshot.data![index].postId,
                                              postTitle: snapshot
                                                  .data![index].postTitle,
                                              postDescrip: snapshot
                                                  .data![index].postDescrip,
                                              postImage: snapshot
                                                  .data![index].postImage),
                                          // onUpdate: _updatePostCallback,
                                        ),
                                        withNavBar:
                                            false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    }),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  tooltip: 'Delete',
                                  onPressed: () async {
                                    await repo.deletePost(
                                        snapshot.data![index].postId);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      )),
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
