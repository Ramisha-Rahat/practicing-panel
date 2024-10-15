import 'package:crudpanel/Controller/imagePickerController.dart';
import 'package:crudpanel/Controller/itemController.dart';
import 'package:crudpanel/View/imagePage.dart';
import 'package:crudpanel/View/secondpage.dart';
import 'package:crudpanel/View/startingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final itemController ItemController = Get.put(itemController());

  final imageController = Get.find<ImagePickerController>();

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              StartingPage()), // Ensure you have a LoginPage defined
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? photoUrl = user?.photoURL;
    final String? displayName = user?.displayName;
    final String? email = user?.email;

    return GetBuilder<itemController>(
        init: itemController(),
        initState: (_) {},
        builder: (itemController) {
          itemController.getData();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellowAccent,
              title: Text('Grocery Items'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    signOut(context);
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Drawer Header showing user profile image
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: Container(
                      child: Row(
                        children: [
                          if (photoUrl !=
                              null) // Display profile picture if available
                            CircleAvatar(
                              backgroundImage: NetworkImage(photoUrl),
                              radius: 30,
                            ),
                          SizedBox(height: 20),
                          Text(
                            '  ${displayName ?? email}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), // Display user's name or 'User' if null
                        ],
                      ),
                    ),
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
                  ListTile(
                    title: const Text('Notifications'),
                    onTap: () { // Navigate to Add Image page
                    },
                  ),
                  ListTile(
                    title: const Text('Log Out'),
                    onTap: () {
                      signOut(context);
                    },
                  ),
                ],
              ),
            ),
            body: Container(
              color: Colors.pink.shade200,
              child: itemController.isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      child: ListView.separated(
                          itemCount: itemController.itemList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Card(
                              child: Column(children: [
                                Text(itemController.itemList[index].name),
                                Text(itemController.itemList[index].Price),
                                Text(itemController.itemList[index].category),
                                Text(
                                    itemController.itemList[index].description),
                                // IconButton(
                                //     onPressed: () {
                                //       itemController.updateItem(
                                //           itemController.itemList[index].item_id,
                                //           'New Name', // Pass updated name
                                //           'New Price', // Pass updated price
                                //           'New Category', // Pass updated category
                                //           'New Description',
                                //       );
                                //     },
                                //     icon: Icon(Icons.edit)),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String newName = itemController.itemList[index].name;
                                        String newPrice = itemController.itemList[index].Price;
                                        String newCategory = itemController.itemList[index].category;
                                        String newDescription = itemController.itemList[index].description;

                                        return AlertDialog(
                                          title: Text("Update Item"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(labelText: 'Name'),
                                                onChanged: (value) => newName = value,
                                                controller: TextEditingController(text: newName),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(labelText: 'Price'),
                                                onChanged: (value) => newPrice = value,
                                                controller: TextEditingController(text: newPrice),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(labelText: 'Category'),
                                                onChanged: (value) => newCategory = value,
                                                controller: TextEditingController(text: newCategory),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(labelText: 'Description'),
                                                onChanged: (value) => newDescription = value,
                                                controller: TextEditingController(text: newDescription),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                // Call updateItem with the correct Firestore document ID
                                                itemController.updateItem(
                                                  newName,
                                                  newPrice,
                                                  newCategory,
                                                  newDescription,
                                                  itemController.itemList[index].item_id, // Correct document ID
                                                );
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: Text("Update"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog without updating
                                              },
                                              child: Text("Cancel"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),

                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    itemController.deleteItem(itemController.itemList[index].item_id);
                                  },
                                ),
                              ]),
                            );
                          },
                          separatorBuilder: (BuildContext context, index) {
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
