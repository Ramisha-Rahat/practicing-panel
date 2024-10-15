import 'package:crudpanel/Controller/itemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class viewPage extends StatefulWidget {
  const viewPage({super.key});

  @override
  State<viewPage> createState() => _viewPageState();
}

class _viewPageState extends State<viewPage> {

  final itemController itemControllerinstance=Get.find<itemController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController idController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body:
      Container(
        color: Colors.white,
        child:
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Item Category'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Item Description'),
              ),
               ElevatedButton(onPressed: (){
                   itemControllerinstance.addItem(
                     nameController.text,
                     priceController.text,
                     categoryController.text,
                     descriptionController.text,
                   );
                   Get.back();
               },
                   child: Text('Add item')),
            ],
          ),
        ),
      ),
    );
  }
}
