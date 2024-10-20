import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


final FirebaseStorage _storage=FirebaseStorage.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

class StoreData{

  Future<String> uploadImageToStorage(String childName, Uint8List file) async{
    Reference ref=_storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot =await uploadTask;
    String downloadUrl=await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future <String> saveData ({
        required String name, required String bio, required Uint8List file
      })
       async
  {
     String res='Some errror occured';
     try {
       if (name.isNotEmpty || bio.isNotEmpty) {
         String imageUrl = await uploadImageToStorage('ProfileImg', file);
         await _firestore.collection('userProfile').add({
           'name': name,
           'bio': bio,
           'imageLink': imageUrl
         });

         res = 'Successful';
       }
     }
     catch(e){
       res=e.toString();
     }
       return res;
  }


}