import 'package:crudpanel/Bindings/controllerbinding.dart';
import 'package:crudpanel/View/authpage.dart';
import 'package:crudpanel/View/homepage.dart';
import 'package:crudpanel/View/imagePage.dart';
import 'package:crudpanel/View/secondpage.dart';
import 'package:crudpanel/View/startingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD PANEL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      initialBinding: Controllerbinding(),
      initialRoute: '/auth-page', // Set the initial route
      getPages: [
        GetPage(name: '/home', page: () => MyHomePage()),
        GetPage(name: '/add-item', page: () => viewPage()),
        GetPage(name: '/add-image', page: () => ImagePage()),
        GetPage(name: '/start-page', page: () => StartingPage()),
        GetPage(name: '/auth-page', page: () => MyAuthPage ()),
      ],
    );
  }
}


