import 'package:crudpanel/View/homepage.dart';
import 'package:crudpanel/View/startingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class  MyAuthPage extends StatelessWidget {
  MyAuthPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData){
            return MyHomePage();
          }
          else{
            return StartingPage();
          }

        },
      ),

    );
  }
}