import 'package:event_flow/pages/home_page.dart';
import 'package:event_flow/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigate to the home page upon successful login.
      Navigator.pushReplacementNamed(context, '/home_page');
      // Navigator.pop(context);
    } catch (e) {
      print("Error signing in: $e");

      // Handle the error appropriately.
      String errorMessage = "An error occurred during sign-in.";

      if (e is FirebaseAuthException) {
        // Check specific FirebaseAuthException codes and show appropriate messages
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for this user.';
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

    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4D608A),
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //username textfield
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
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Sign In',
              onTap: () => signUserIn(context),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[200]),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    // Navigate to the signup page when "Register now" is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()
                      ),
                    );
                  },
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
