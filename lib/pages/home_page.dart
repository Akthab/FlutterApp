import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  // 'Laptop',
                  'Logged In as ${user.email!}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   onTap: (index) {
        //     switch (index) {
        //       case 0:
        //         Get.to(HomePage());
        //         break;
        //       case 1:
        //         Get.to(() => const AddNewPostPage());
        //         break;
        //       case 2:
        //         Get.to(() => const PostViewScreen());
        //         break;
        //       case 3:
        //         Get.toNamed('/notifications');
        //         break;
        //     }
        //   },
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home,
        //         color: Colors.black,
        //       ),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.person,
        //         color: Colors.black,
        //       ),
        //       label: 'Profile',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.settings,
        //         color: Colors.black,
        //       ),
        //       label: 'Settings',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.black,
        //       ),
        //       label: 'Notifications',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
