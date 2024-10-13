import 'package:crudpanel/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class itemController extends GetxController{

  var isLoading=false;
  var itemList=<itemModel>[];


  Future<void> getData() async{

  try{
    QuerySnapshot items= await FirebaseFirestore.instance.collection('grocery_items').orderBy('name').get();
    itemList.clear();
    for(var item in items.docs){
    itemList.add(itemModel(item['Price'], item['description'],
        item['category'],item['name'], item.id
    )
    );
    }
    isLoading=false;
  }
    catch (e){
    Get.snackbar('error', '${e.toString()}');
    }
  update();
  }

  Future<void> addItem(String name, String price, String category, String description, String item_id) async {
    try {
      isLoading = true;
      update();

      await FirebaseFirestore.instance.collection('grocery_items').add({
        'name': name,
        'Price': price,
        'category': category,
        'description': description,
      });

      getData();  // Refresh the data after adding new item
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }
}


