import 'package:crudpanel/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();

  Future<void> signIn(String email, String password) async {
    try {
      await authService.signInWithEmailAndPassword(email, password);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await authService.signInWithGoogle();
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
    }
  }
}
