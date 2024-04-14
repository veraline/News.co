import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_button.dart';
import '../../widgets/my_textfeild.dart';
import '../../widgets/square_tile.dart';
import '../home_page.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final userNameController = TextEditingController();

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Register method
  void registerUser() async {
    //show loading
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });

    try {
      // creating the user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      Navigator.pop(context);

      // Show Snackbar with success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
          (route) =>false
      );
    } catch (e) {
      // Hide loading indicator
      Navigator.pop(context);

      // Show Snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                //logo , icon or image
                // Image.asset(
                //   'assets/login img.png',
                //   height: 170,
                // ),
            const Icon(Icons.person,size: 150,),
                const SizedBox(
                  height: 20,
                ),
                //Text
                Text(
                  'Create an Account with us 🤭',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                //username text-field
                MyTextField(
                  obsecureText: false,
                  controller: userNameController,
                  icon: const Icon(Icons.person),
                  hinttext: 'Enter your username',
                ),
                // email text-field
                const SizedBox(height: 5,),
                MyTextField(
                  controller: emailController,
                  icon: const Icon(Icons.email),
                  hinttext: 'Enter your email',
                  obsecureText: false,
                ),
                const SizedBox(
                  height: 5,
                ),
                //password text-field
                MyTextField(
                  controller: passwordController,
                  icon: const Icon(Icons.lock_outline),
                  hinttext: 'Enter your password',
                  obsecureText: true,
                ),

                const SizedBox(
                  height: 20,
                ),
                //Button
                MyButton(
                  text: 'Register ',
                  onTap: registerUser,
                ),

                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Google or twitter

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareContainer(
                      onTap: (){},
                        imagePath: 'assets/google.png'),
                    const SizedBox(
                      width: 25,
                    ),
                    SquareContainer(
                      onTap: (){},
                        imagePath: 'assets/twitter 2.png')
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                //not a member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
