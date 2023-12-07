import 'package:event_flow/components/my_button.dart';
import 'package:event_flow/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupPage({super.key});

  void signUpUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Optionally, you can do something after a successful registration,
      // such as navigate to the home page or show a success message.

      // Example:
      // Navigator.pushReplacementNamed(context, '/home');
      Navigator.pushReplacementNamed(context, '/home_page');
    } catch (e) {
      print("Error signing up: $e");

      // Handle the error appropriately.
      String errorMessage = "An error occurred during sign-up.";

      if (e is FirebaseAuthException) {
        // Check specific FirebaseAuthException codes and show appropriate messages
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'The email address is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
        // Add more cases as needed
        }
      }

      // Show a SnackBar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4D608A),

      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 10,),
            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Sign Up',
              onTap: () => signUpUser(context),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member?',
                  style: TextStyle(color: Colors.grey[200]),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    // Navigate to the signup page when "Register now" is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()
                      ),
                    );
                  },
                  child: const Text(
                    'Login now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () => signUpUser(context),
            //   child: Text('Sign Up'),
            // ),
          ],
        ),
      ),
    );
  }
}
