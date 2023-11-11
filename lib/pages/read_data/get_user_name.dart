import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('Post Title: ${data['postTitle']} Post Description: ${data['postDescrip']}');
          }
          return const Text('Loading');
        });
  }
}
