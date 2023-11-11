import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
                child: Column(
                  children: [
                    Lottie.network(
                        'https://lottie.host/c57a644b-3774-4e4f-94a3-4531797569d6/Yn46iq3VlP.json'),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome ${user.email!}',
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 600),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
