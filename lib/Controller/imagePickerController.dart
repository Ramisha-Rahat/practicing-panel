import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {

  Rx<File> image = Rx<File>(File(''));

  RxString imageUrl = ''.obs;

  Future<void> imagePicker() async {
    try {
      final imagePick = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (imagePick == null) {
        return;
      }
      final imageTemp = File(imagePick.path);
      image.value = imageTemp;
    }
    on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Function to upload the image to Firebase Storage and save the URL to Firestore
  Future<void> saveImageToFirestore() async {
    if (image.value.path == '') return;

    try {
      // Create a unique file name based on timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');

      // Upload the file
      UploadTask uploadTask = storageRef.putFile(image.value);

      // Get download URL after upload completes
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Save the image URL to Firestore under a 'users' collection (you can modify the path as needed)
      await FirebaseFirestore.instance.collection('users').doc('some_user_id').set({
        'imageUrl': downloadUrl,
      });

      // Update the Rx imageUrl with the new URL
      imageUrl.value = downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // Function to fetch image URL from Firestore if already saved (on app startup or page load)
  Future<void> fetchSavedImage() async {
    try {
      // Fetch the stored image URL from Firestore
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc('some_user_id').get();
      if (documentSnapshot.exists) {
        imageUrl.value = documentSnapshot['imageUrl'] ?? '';
      }
    } catch (e) {
      print('Error fetching image URL: $e');
    }
  }

}
