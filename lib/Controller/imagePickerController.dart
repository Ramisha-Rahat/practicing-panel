import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker=ImagePicker();
  XFile? _file= await _imagePicker.pickImage(source: source);
  if(_file!=null){
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}



// Function to upload image to Firebase Storage and save to Firestore
  // Future<void> saveImageToFirestore(String title) async {
  //   if (image.value.path == '') return;
  //
  //   try {
  //     // Generate unique file name for Firebase Storage
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
  //
  //     // Upload the file to Firebase Storage
  //     UploadTask uploadTask = storageRef.putFile(image.value);
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //
  //     // Get download URL from Firebase Storage
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //
  //     // Save image URL and metadata (like title) to Firestore
  //     await FirebaseFirestore.instance.collection('image_items').add({
  //       'imageUrl': downloadUrl,  // The URL to the image
  //       'title': title,  // Title or any other metadata
  //       'timestamp': FieldValue.serverTimestamp(),  // Adding timestamp for ordering purposes
  //     });
  //
  //     imageUrl.value = downloadUrl;  // Update the observable value with the new URL
  //     print('Image saved successfully');
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  // }

  // Fetching saved image from Firestore
  // Future<void> fetchSavedImage(String docId) async {
  //   try {
  //     // Fetch the stored image URL from Firestore
  //     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('image_items').doc(docId).get();
  //     if (documentSnapshot.exists) {
  //       imageUrl.value = documentSnapshot['imageUrl'] ?? '';
  //     }
  //   } catch (e) {
  //     print('Error fetching image URL: $e');
  //   }
  // }

  // Updating the image in Firestore
  // Future<void> updateImageInFirestore(String docId) async {
  //   if (image.value.path == '') return;
  //
  //   try {
  //     // Generate new file name
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
  //
  //     // Upload the updated image
  //     UploadTask uploadTask = storageRef.putFile(image.value);
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //
  //     // Get new download URL
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //
  //     // Update Firestore document with new image URL
  //     await FirebaseFirestore.instance.collection('image_items').doc(docId).update({
  //       'imageUrl': downloadUrl,
  //     });
  //
  //     imageUrl.value = downloadUrl;  // Update the image URL locally
  //     print('Image updated successfully');
  //   } catch (e) {
  //     print('Error updating image: $e');
  //   }
  // }

  // Deleting the image from Firestore
  // Future<void> deleteImageFromFirestore(String docId) async {
  //   try {
  //     // Remove the image URL from the Firestore document
  //     await FirebaseFirestore.instance.collection('image_items').doc(docId).delete();
  //
  //     // Optionally, delete the image file from Firebase Storage as well (optional)
  //     // await FirebaseStorage.instance.refFromURL(imageUrl.value).delete();
  //
  //     imageUrl.value = '';  // Reset the image URL
  //     image.value = File('');  // Clear the local image file
  //     print('Image deleted successfully');
  //   } catch (e) {
  //     print('Error deleting image: $e');
  //   }
  // }

