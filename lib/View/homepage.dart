import 'package:crudpanel/Controller/imagePickerController.dart';
import 'package:crudpanel/Controller/itemController.dart';
import 'package:crudpanel/View/imagePage.dart';
import 'package:crudpanel/View/secondpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final itemController ItemController=Get.put(itemController());

  final imageController = Get.find<ImagePickerController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<itemController>
      (
      init:itemController() ,
        initState: (_){},
        builder:(itemController){
        itemController.getData();

      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Grocery Items'),
        centerTitle: true,

      ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header showing user profile image
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Obx(() {
                return imageController.imageUrl.value == ''
                    ? const Icon(Icons.person, size: 100)
                    : Image.network(imageController.imageUrl.value); // Display the saved image
              }),
            ),
            // Navigation Items
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              title: const Text('Add Item'),
              onTap: () {
                Get.to(viewPage()); // Navigate to Add Item page
              },
            ),
            ListTile(
              title: const Text('Add Image'),
              onTap: () {
                Get.to(ImagePage()); // Navigate to Add Image page
              },
            ),
          ],
        ),
        ),
        body:
        Container(
          color: Colors.pink.shade200,
          child :itemController.isLoading? CircularProgressIndicator() :
              Container(
                   child: ListView.separated(
                     itemCount: itemController.itemList.length,
                       itemBuilder:(BuildContext context, index){
                       return Card(
                         child: Column(
                           children: [
                             Text(itemController.itemList[index].name),
                             Text(itemController.itemList[index].Price),
                             Text(itemController.itemList[index].category),
                             Text(itemController.itemList[index].description),
                           ]),
                       );
                       },
                     separatorBuilder: (BuildContext context, index){
                       return Divider(
                         thickness: 2,
                       );
                     }),
              ),
        ),
);
        });
  }
}
