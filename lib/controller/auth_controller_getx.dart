import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';

class AuthController extends GetxController {
  final user = Rxn<User>();

  @override
  void onReady() {
    super.onReady();
    user.bindStream(FirebaseAuthHelper.firebaseAuthHelper.onAuthStateChanged);
    update();
  }
}
