import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import '../Controller/profileData.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  Uint8List? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // Function to pick an image
  Future<Uint8List?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return await pickedFile.readAsBytes(); // Convert the image to Uint8List
    }
    return null;
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery); // Call the pickImage function
    setState(() {
      _image = img; // Update the image state
    });
  }

  void addProfile() async {
    // Instantiate StoreData class
    StoreData storeData = StoreData();

    String name = nameController.text;
    String bio = bioController.text;

    // Check if image is selected
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    // Check if name and bio are not empty
    if (name.isEmpty || bio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Call the saveData function
    String res = await storeData.saveData(
      name: name,
      bio: bio,
      file: _image!,
    );

    if (res == 'Successful') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $res')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        title: const Text('Register Yourself'),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                // Display image if selected, else show default CircleAvatar
                _image != null
                    ? CircleAvatar(
                  radius: 85,
                  backgroundImage: MemoryImage(_image!), // Display the selected image
                )
                    : const CircleAvatar(
                    radius: 85, backgroundColor: Colors.white),
                // Positioned button to add image
                Positioned(
                  bottom: 5,
                  right: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: IconButton(
                      onPressed: selectImage, // Call the selectImage function
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30), // Space between avatar and form
            // Text field for Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name', // Adds a label
                labelStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black, // Border color
                    width: 2, // Border thickness
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Color when focused
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, // Vertical padding
                  horizontal: 10, // Horizontal padding
                ),
              ),
            ),
            const SizedBox(height: 30), // Space between text fields
            // Text field for Bio
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: 'Enter your bio', // Adds a label
                labelStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black, // Border color
                    width: 2, // Border thickness
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Color when focused
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, // Vertical padding
                  horizontal: 10, // Horizontal padding
                ),
              ),
              maxLines: 4, // Allow multiple lines for the bio input
            ),
            const SizedBox(height: 30), // Space before the button
            ElevatedButton(
              onPressed: addProfile, // Call addProfile on button press
              child: const Text('Save My Data'),
            ),
          ],
        ),
      ),
    );
  }
}
