import 'package:crudpanel/Controller/imagePickerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  final imageController = Get.put(ImagePickerController());

  @override
  void initState() {
    super.initState();
    // Fetch the image URL if it was previously saved
    imageController.fetchSavedImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
          child: imageController.image.value.path == '' && imageController.imageUrl.value == ''
          ? const Icon(Icons.person, size: 100)
              : imageController.imageUrl.value != ''
          ? Image.network(imageController.imageUrl.value) // Display image from Firestore
              : Image.file(imageController.image.value), // Display selected image before upload
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      imageController.imagePicker(); // Call the image picker function
                    },
                    child: const Text('Add Image'),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                      onPressed: () async {
                        await imageController.saveImageToFirestore(); // Save the image to Firestore
                      },
                      child: Text('Save')),
                ],
              ),
              SizedBox(height: 30,),
              Container(
                child: Column(
                  children: [
                    Text('The image that you have saved is :'),
              SizedBox(height: 30,),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.black),
                    bottom: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                      left:BorderSide(color: Colors.black),
                  )
                ),
              )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
