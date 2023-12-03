import 'package:event_flow/pages/login_page.dart';
import 'package:event_flow/pages/signup_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4D608A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/images/main.png'),
            const SizedBox(height: 20),
            const Text(
              'EVENT FLOW',
              style: TextStyle(
                fontSize: 34.0,
                fontFamily: 'Montserrat',
                letterSpacing: 7,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: const Color(0xffF5E9E2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xffF5E9E2)),
                        )
                    ),
                    child: const Text('Sign in')
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white),
                        )
                    ),
                    child: const Text('Sign up')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
