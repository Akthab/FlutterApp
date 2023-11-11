import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:new_app/components/my_button.dart';
import 'package:new_app/components/my_textfield.dart';
import 'package:new_app/pages/post_view_screen.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({Key? key}) : super(key: key);

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  bool _isLoading = false;
  File? _pickedImage;
  final postTileController = TextEditingController();
  final postDescripContoller = TextEditingController();

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> getImageFromUser() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      File imageFile = File(pickedFile.path);
      String downloadUrl = await uploadImageToFirebase(imageFile);
      return downloadUrl;
    } else {
      setState(() {
        _pickedImage = null;
      });
      return null;
    }
  }

  void addPost() async {
    setState(() {
      _isLoading = true;
    });
    // Upload the image to Firebase Storage and get the download URL
    String downloadUrl = await uploadImageToFirebase(_pickedImage!);

    // Store the post data in Firestore
    final postRef = FirebaseFirestore.instance.collection('posts').doc();
    final post = {
      'postId': postRef.id,
      'imageUrl': downloadUrl,
      'postTitle': postTileController.text,
      'postDescrip': postDescripContoller.text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    await postRef.set(post);

    // Clear the text fields and image
    postTileController.clear();
    postDescripContoller.clear();

    setState(() {
      _pickedImage = null;
      _isLoading = false;
    });

    // Show a snackbar to indicate the post was added successfully
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
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
                      child: _pickedImage == null
                          ? const Text('Select Image')
                          : Image.file(
                              File(_pickedImage!.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImageFromUser,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            MyTextField(
                controller: postTileController,
                hintText: 'Post Title',
                obscureText: false),
            const SizedBox(height: 20),
            MyTextField(
                controller: postDescripContoller,
                hintText: 'Post Description',
                obscureText: false),
            const SizedBox(
              height: 100,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : MyButton(onTap: addPost, btnText: 'Submit'),
          ],
        ),
      ),
    );
  }
}
