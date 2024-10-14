import 'package:crudpanel/View/homepage.dart';
import 'package:crudpanel/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatefulWidget {
      const StartingPage({super.key});
      @override
      State<StartingPage> createState() => _StartingPageState();
    }

    class _StartingPageState extends State<StartingPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signin(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );// Remove the loading dialog after successful sign in
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Remove the loading dialog before showing the error
      showErrorMessage(context, e.message ?? 'An error occurred');
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.white,
            width: double.infinity,
            child: SingleChildScrollView(
                child:  Column(
                  children: [
                    Container(
                        width: 300,
                        child: TextField(
                          controller: usernameController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.black), // Set label text color to black
                            hintText: 'Enter your username',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20.0),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: Colors.black, // Hides the text input for password fields
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password  '),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 70),
                    child: ElevatedButton(
                      onPressed: () => signin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // Adjust corner radius as needed
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("OR CONTINUE WITH"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 120),
                      GestureDetector(
                        onTap: ()=>AuthService().signInWithGoogle(),
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 100,
                          width: 50,
                        ),
                      ),
                      SizedBox(width: 30),
                      Image.asset(
                        'assets/images/apple.png',
                        height: 100,
                        width: 50,
                      ),
                    ],
                  ),
              ],
                ),
              ),
            ),
        );
      }
    }
