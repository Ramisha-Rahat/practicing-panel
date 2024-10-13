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
            mainAxisAlignment: MainAxisAlignment.center,
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
                children: [
                  ElevatedButton(
                    onPressed: () {
                      imageController.imagePicker(); // Call the image picker function
                    },
                    child: const Text('Add Image'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await imageController.saveImageToFirestore(); // Save the image to Firestore
                      },
                      child: Text('Save')),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
