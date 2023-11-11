import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/my_button.dart';
import 'package:new_app/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => __ForgotPasswordPageState();
}

class __ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  void resetPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey[400]),
          );
        });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Navigator.pop(context);
      validateReset("Password reset link sent, Please check your email");
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (emailController.text.isEmpty) {
        validateReset("Please fill all the fields");
      } else if (e.code == 'user-not-found') {
        validateReset("Incorrect Email");
      } else if (e.code == 'invalid-email') {
        validateReset("Invalid Email format");
      } else {
        validateReset(e.code);
      }
    }
  }

  void validateReset(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('Enter your email'),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 30),
            MyButton(
              onTap: resetPassword,
              btnText: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
