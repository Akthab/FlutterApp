import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/components/my_button.dart';
import 'package:new_app/models/post_model.dart';
import 'package:new_app/pages/post_view_screen.dart';
import 'package:new_app/repository/post_repository.dart';

class UpdatePostScreen extends StatefulWidget {
  final PostModel post;
  // final Function onUpdate;

  const UpdatePostScreen({
    Key? key,
    required this.post,
    // required this.onUpdate,
  }) : super(key: key);

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  final repo = Get.find<PostRepository>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.postTitle;
    _descriptionController.text = widget.post.postDescrip;
    _imageController.text = widget.post.postImage;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _updatePost() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      final updatedPost = PostModel(
        postId: widget.post.postId,
        postTitle: _titleController.text,
        postDescrip: _descriptionController.text,
        postImage: _imageController.text,
      );
      await repo.updatePost(updatedPost);
      setState(() {
        _isLoading = false;
      });
      // widget.onUpdate();
      Get.to(() => const PostViewScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                          ),
                          fillColor: Colors.white30,
                          filled: true,
                          labelText: 'Post Title',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                          ),
                          fillColor: Colors.white30,
                          filled: true,
                          labelText: 'Post Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [6, 3],
                          color: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Image.network(
                                  widget.post.postImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 46),
              _isLoading
                  ? const CircularProgressIndicator()
                  : MyButton(onTap: _updatePost, btnText: 'Update')
              // ElevatedButton(
              //   onPressed: _updatePost,
              //   child: const Text('Update Post'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
