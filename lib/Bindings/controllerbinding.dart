import 'package:crudpanel/Controller/imagePickerController.dart';
import 'package:crudpanel/Controller/itemController.dart';
import 'package:get/get.dart';

class Controllerbinding extends Bindings{
  @override
  void dependencies() {
    Get.put<itemController>(itemController());
    Get.put(ImagePickerController());
  }

}